import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/reminder_types.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/reminder_entity.dart';
import '../../../services/notification_service.dart';
import '../../providers/notification_providers.dart';
import '../../providers/reminder_providers.dart';

class ReminderFormArgs {
  final int vehicleId;
  final ReminderEntity? reminder;
  const ReminderFormArgs({required this.vehicleId, this.reminder});
}

class ReminderFormScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  final ReminderEntity? reminder;

  const ReminderFormScreen({super.key, required this.vehicleId, this.reminder});

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  late ReminderType _selectedType;
  late DateTime _dueDate;
  bool _isSaving = false;

  bool get _isEditing => widget.reminder != null;

  @override
  void initState() {
    super.initState();
    final r = widget.reminder;
    _selectedType = r?.type ?? ReminderType.documentation;
    _dueDate = r?.dueDate ?? DateTime.now().add(const Duration(days: 30));
    _titleController = TextEditingController(text: r?.title ?? '');
    _notesController = TextEditingController(text: r?.notes ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final entity = ReminderEntity(
      id: widget.reminder?.id,
      vehicleId: widget.vehicleId,
      type: _selectedType,
      title: _titleController.text.trim(),
      dueDate: _dueDate,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final result = _isEditing
        ? await ref.read(updateReminderUsecaseProvider).call(entity)
        : await ref.read(addReminderUsecaseProvider).call(entity);

    if (!mounted) return;

    await result.when(
      success: (savedId) async {
        final id = entity.id ?? savedId as int;
        final notificationId = NotificationService.notificationIdFor(id);
        final service = ref.read(notificationServiceProvider);

        // Reagenda do zero — evita duplicidade se o usuário editar a data.
        await service.cancel(notificationId);
        await service.scheduleReminder(
          id: notificationId,
          title: 'Lembrete: ${entity.title}',
          body:
              '${entity.type.label} vence em '
              '${Formatters.date(entity.dueDate)}',
          date: entity.dueDate.subtract(const Duration(days: 3)),
        );
      },
      failure: (_) async {},
    );

    setState(() => _isSaving = false);
    if (!mounted) return;

    result.when(
      success: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Lembrete atualizado' : 'Lembrete criado',
            ),
          ),
        );
        context.pop();
      },
      failure: (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $error')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Lembrete' : 'Novo Lembrete'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<ReminderType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: ReminderType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedType = v);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ex: Vencimento do seguro anual',
              ),
              validator: (v) => Validators.required(v, fieldName: 'Título'),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Data de vencimento',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(Formatters.date(_dueDate)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Você será notificado 3 dias antes do vencimento.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações (opcional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(_isEditing ? 'Salvar Alterações' : 'Criar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }
}
