import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/vehicle_entity.dart';
import '../../../services/image_service.dart';
import '../../providers/vehicle_providers.dart';

class VehicleFormScreen extends ConsumerStatefulWidget {
  final VehicleEntity? vehicle;
  const VehicleFormScreen({super.key, this.vehicle});

  @override
  ConsumerState<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends ConsumerState<VehicleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _plateController;
  late final TextEditingController _colorController;
  late final TextEditingController _mileageController;

  String? _photoPath;
  bool _isSaving = false;

  bool get _isEditing => widget.vehicle != null;

  @override
  void initState() {
    super.initState();
    final v = widget.vehicle;
    _brandController = TextEditingController(text: v?.brand ?? '');
    _modelController = TextEditingController(text: v?.model ?? '');
    _yearController = TextEditingController(text: v?.year.toString() ?? '');
    _plateController = TextEditingController(text: v?.plate ?? '');
    _colorController = TextEditingController(text: v?.color ?? '');
    _mileageController = TextEditingController(
      text: v?.currentMileage.toStringAsFixed(0) ?? '',
    );
    _photoPath = v?.photoPath;
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _colorController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final path = await ImageService.pickAndSaveImage();
    if (path != null && mounted) {
      setState(() => _photoPath = path);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final entity = VehicleEntity(
      id: widget.vehicle?.id,
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      year: int.parse(_yearController.text.trim()),
      plate: _plateController.text.trim().toUpperCase(),
      color: _colorController.text.trim(),
      currentMileage: double.parse(
        _mileageController.text.trim().replaceAll(',', '.'),
      ),
      photoPath: _photoPath,
      createdAt: widget.vehicle?.createdAt ?? DateTime.now(),
    );

    final result = _isEditing
        ? await ref.read(updateVehicleUsecaseProvider).call(entity)
        : await ref.read(addVehicleUsecaseProvider).call(entity);

    if (!mounted) return;
    setState(() => _isSaving = false);

    result.when(
      success: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Veículo atualizado' : 'Veículo cadastrado',
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
        title: Text(_isEditing ? 'Editar Veículo' : 'Novo Veículo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: _PhotoPicker(photoPath: _photoPath),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Marca'),
              textCapitalization: TextCapitalization.words,
              validator: (v) => Validators.required(v, fieldName: 'Marca'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(labelText: 'Modelo'),
              textCapitalization: TextCapitalization.words,
              validator: (v) => Validators.required(v, fieldName: 'Modelo'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(labelText: 'Ano'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validators.year,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _colorController,
                    decoration: const InputDecoration(labelText: 'Cor'),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => Validators.required(v, fieldName: 'Cor'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _plateController,
              decoration: const InputDecoration(
                labelText: 'Placa',
                hintText: 'ABC1D23 ou ABC1234',
              ),
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [_UpperCaseTextFormatter()],
              validator: Validators.plate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mileageController,
              decoration: const InputDecoration(
                labelText: 'Quilometragem atual',
                suffixText: 'km',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              validator: Validators.mileage,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      _isEditing ? 'Salvar Alterações' : 'Cadastrar Veículo',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  final String? photoPath;
  const _PhotoPicker({required this.photoPath});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoPath != null && File(photoPath!).existsSync();

    return Stack(
      children: [
        CircleAvatar(
          radius: 56,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundImage: hasPhoto ? FileImage(File(photoPath!)) : null,
          child: !hasPhoto
              ? Icon(
                  Icons.directions_car,
                  size: 40,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
