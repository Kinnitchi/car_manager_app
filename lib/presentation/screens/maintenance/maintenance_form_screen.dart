import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/maintenance_types.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/masked_number_formatter.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/maintenance_entity.dart';
import '../../providers/maintenance_providers.dart';
import '../../providers/vehicle_providers.dart';

/// Argumentos passados via `extra` do GoRouter para esta tela.
class MaintenanceFormArgs {
  final int vehicleId;
  final MaintenanceEntity? maintenance;

  const MaintenanceFormArgs({required this.vehicleId, this.maintenance});
}

class MaintenanceFormScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  final MaintenanceEntity? maintenance;

  const MaintenanceFormScreen({
    super.key,
    required this.vehicleId,
    this.maintenance,
  });

  @override
  ConsumerState<MaintenanceFormScreen> createState() =>
      _MaintenanceFormScreenState();
}

class _MaintenanceFormScreenState extends ConsumerState<MaintenanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descriptionController;
  late final TextEditingController _mileageController;
  late final TextEditingController _costController;
  late final TextEditingController _workshopController;
  late final TextEditingController _notesController;

  late MaintenanceType _selectedType;
  late DateTime _selectedDate;
  bool _isSaving = false;

  bool get _isEditing => widget.maintenance != null;

  @override
  void initState() {
    super.initState();
    final m = widget.maintenance;
    final vehicle = ref.read(selectedVehicleProvider);

    _selectedType = m?.type ?? MaintenanceType.oilChange;
    _selectedDate = m?.date ?? DateTime.now();
    _descriptionController = TextEditingController(text: m?.description ?? '');
    final initialMileage = m?.mileage ?? vehicle?.currentMileage;
    _mileageController = TextEditingController(
      text: initialMileage != null
          ? Formatters.maskedNumber(initialMileage)
          : '',
    );
    _costController = TextEditingController(
      text: m != null ? Formatters.maskedNumber(m.cost, decimalDigits: 2) : '',
    );
    _workshopController = TextEditingController(text: m?.workshop ?? '');
    _notesController = TextEditingController(text: m?.notes ?? '');
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _mileageController.dispose();
    _costController.dispose();
    _workshopController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final mileage = Formatters.parseMaskedNumber(_mileageController.text)!;
    final cost = Formatters.parseMaskedNumber(_costController.text) ?? 0;

    final entity = MaintenanceEntity(
      id: widget.maintenance?.id,
      vehicleId: widget.vehicleId,
      type: _selectedType,
      description: _descriptionController.text.trim(),
      date: _selectedDate,
      mileage: mileage,
      cost: cost,
      workshop: _workshopController.text.trim().isEmpty
          ? null
          : _workshopController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final result = _isEditing
        ? await ref.read(updateMaintenanceUsecaseProvider).call(entity)
        : await ref.read(addMaintenanceUsecaseProvider).call(entity);

    if (!mounted) return;

    final success = result.isSuccess;
    if (success) {
      await _syncVehicleMileageIfNeeded(mileage);
    }

    setState(() => _isSaving = false);
    if (!mounted) return;

    result.when(
      success: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Manutenção atualizada' : 'Manutenção registrada',
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

  /// Se a km informada na manutenção for maior que a km atual salva no
  /// veículo, atualiza o veículo também — mantém o Dashboard consistente.
  Future<void> _syncVehicleMileageIfNeeded(double mileage) async {
    final vehicle = ref.read(selectedVehicleProvider);
    if (vehicle == null || mileage <= vehicle.currentMileage) return;

    final updated = vehicle.copyWith(currentMileage: mileage);
    final result = await ref.read(updateVehicleUsecaseProvider).call(updated);
    result.when(
      success: (_) =>
          ref.read(selectedVehicleProvider.notifier).select(updated),
      failure: (_) {}, // não bloqueia o fluxo principal por isso
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Manutenção' : 'Nova Manutenção'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<MaintenanceType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Tipo de manutenção',
              ),
              items: MaintenanceType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedType = value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Ex: Troca de óleo 5W30 + filtro',
              ),
              maxLines: 2,
              validator: (v) => Validators.required(v, fieldName: 'Descrição'),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Data',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(Formatters.date(_selectedDate)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mileageController,
              decoration: const InputDecoration(
                labelText: 'Quilometragem',
                suffixText: 'km',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: const [MaskedNumberInputFormatter()],
              validator: Validators.mileage,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _costController,
              decoration: const InputDecoration(
                labelText: 'Valor gasto',
                prefixText: 'R\$ ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: const [
                MaskedNumberInputFormatter(decimalDigits: 2),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _workshopController,
              decoration: const InputDecoration(
                labelText: 'Oficina (opcional)',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações (opcional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
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
                  : Text(_isEditing ? 'Salvar Alterações' : 'Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
