import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/fuel_types.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/masked_number_formatter.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/fuel_entity.dart';
import '../../providers/fuel_providers.dart';
import '../../providers/vehicle_providers.dart';

class FuelFormArgs {
  final int vehicleId;
  final FuelEntity? fuel;
  const FuelFormArgs({required this.vehicleId, this.fuel});
}

class FuelFormScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  final FuelEntity? fuel;

  const FuelFormScreen({super.key, required this.vehicleId, this.fuel});

  @override
  ConsumerState<FuelFormScreen> createState() => _FuelFormScreenState();
}

class _FuelFormScreenState extends ConsumerState<FuelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _litersController;
  late final TextEditingController _totalValueController;
  late final TextEditingController _mileageController;

  late FuelType _selectedType;
  late DateTime _selectedDate;
  late bool _fullTank;
  double _pricePerLiter = 0;
  bool _isSaving = false;

  bool get _isEditing => widget.fuel != null;

  @override
  void initState() {
    super.initState();
    final f = widget.fuel;
    final vehicle = ref.read(selectedVehicleProvider);

    _selectedType = f?.fuelType ?? FuelType.gasoline;
    _selectedDate = f?.date ?? DateTime.now();
    _fullTank = f?.fullTank ?? true;
    _pricePerLiter = f?.pricePerLiter ?? 0;

    _litersController = TextEditingController(
      text: f != null
          ? Formatters.maskedNumber(f.liters, decimalDigits: 2)
          : '',
    )..addListener(_recalculatePrice);

    _totalValueController = TextEditingController(
      text: f != null
          ? Formatters.maskedNumber(f.totalValue, decimalDigits: 2)
          : '',
    )..addListener(_recalculatePrice);

    final initialMileage = f?.mileage ?? vehicle?.currentMileage;
    _mileageController = TextEditingController(
      text: initialMileage != null
          ? Formatters.maskedNumber(initialMileage)
          : '',
    );
  }

  @override
  void dispose() {
    _litersController.dispose();
    _totalValueController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  /// Preço por litro é sempre derivado de Litros e Valor Total —
  /// evita inconsistência entre os três campos (o usuário nunca
  /// digita o preço por litro diretamente).
  void _recalculatePrice() {
    final liters = Formatters.parseMaskedNumber(_litersController.text);
    final total = Formatters.parseMaskedNumber(_totalValueController.text);
    if (liters != null && liters > 0 && total != null) {
      setState(() => _pricePerLiter = total / liters);
    } else {
      setState(() => _pricePerLiter = 0);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final liters = Formatters.parseMaskedNumber(_litersController.text)!;
    final total = Formatters.parseMaskedNumber(_totalValueController.text)!;
    final mileage = Formatters.parseMaskedNumber(_mileageController.text)!;

    final entity = FuelEntity(
      id: widget.fuel?.id,
      vehicleId: widget.vehicleId,
      date: _selectedDate,
      fuelType: _selectedType,
      liters: liters,
      totalValue: total,
      pricePerLiter: liters > 0 ? total / liters : 0,
      mileage: mileage,
      fullTank: _fullTank,
    );

    final result = _isEditing
        ? await ref.read(updateFuelUsecaseProvider).call(entity)
        : await ref.read(addFuelUsecaseProvider).call(entity);

    if (!mounted) return;

    if (result.isSuccess) {
      await _syncVehicleMileageIfNeeded(mileage);
    }

    setState(() => _isSaving = false);
    if (!mounted) return;

    result.when(
      success: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Abastecimento atualizado'
                  : 'Abastecimento registrado',
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

  Future<void> _syncVehicleMileageIfNeeded(double mileage) async {
    final vehicle = ref.read(selectedVehicleProvider);
    if (vehicle == null || mileage <= vehicle.currentMileage) return;

    final updated = vehicle.copyWith(currentMileage: mileage);
    final result = await ref.read(updateVehicleUsecaseProvider).call(updated);
    result.when(
      success: (_) =>
          ref.read(selectedVehicleProvider.notifier).select(updated),
      failure: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Abastecimento' : 'Novo Abastecimento'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<FuelType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Tipo de combustível',
              ),
              items: FuelType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedType = value);
              },
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _litersController,
                    decoration: const InputDecoration(
                      labelText: 'Litros',
                      suffixText: 'L',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: const [
                      MaskedNumberInputFormatter(decimalDigits: 2),
                    ],
                    validator: (v) {
                      final val = Formatters.parseMaskedNumber(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Litros inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _totalValueController,
                    decoration: const InputDecoration(
                      labelText: 'Valor total',
                      prefixText: 'R\$ ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: const [
                      MaskedNumberInputFormatter(decimalDigits: 2),
                    ],
                    validator: (v) {
                      final val = Formatters.parseMaskedNumber(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _pricePerLiter > 0
                  ? 'Preço por litro: ${Formatters.currency(_pricePerLiter)}'
                  : 'Preço por litro: --',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mileageController,
              decoration: const InputDecoration(
                labelText: 'Quilometragem atual',
                suffixText: 'km',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: const [MaskedNumberInputFormatter()],
              validator: Validators.mileage,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tanque cheio'),
              subtitle: const Text(
                'Necessário para calcular o consumo médio com precisão',
              ),
              value: _fullTank,
              onChanged: (value) => setState(() => _fullTank = value),
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
                  : Text(_isEditing ? 'Salvar Alterações' : 'Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
