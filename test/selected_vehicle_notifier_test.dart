import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:car_manager_app/domain/entities/vehicle_entity.dart';
import 'package:car_manager_app/presentation/providers/vehicle_providers.dart';

VehicleEntity _vehicle({int id = 1, double mileage = 10000}) => VehicleEntity(
  id: id,
  brand: 'Fiat',
  model: 'Argo',
  year: 2022,
  plate: 'ABC1D23',
  color: 'Prata',
  currentMileage: mileage,
  createdAt: DateTime(2024, 1, 1),
);

void main() {
  group('SelectedVehicleNotifier', () {
    late StreamController<List<VehicleEntity>> vehiclesController;
    late ProviderContainer container;

    setUp(() {
      vehiclesController = StreamController<List<VehicleEntity>>();
      container = ProviderContainer(
        overrides: [
          vehicleListProvider.overrideWith((ref) => vehiclesController.stream),
        ],
      );
    });

    tearDown(() {
      container.dispose();
      vehiclesController.close();
    });

    test('inicia sem veículo selecionado', () {
      expect(container.read(selectedVehicleProvider), isNull);
    });

    test('select define o veículo ativo', () {
      final vehicle = _vehicle();
      container.read(selectedVehicleProvider.notifier).select(vehicle);
      expect(container.read(selectedVehicleProvider), vehicle);
    });

    test('atualiza a instância selecionada quando o veículo muda no banco',
        () async {
      container.read(selectedVehicleProvider.notifier).select(_vehicle());

      vehiclesController.add([_vehicle(mileage: 12500)]);
      await Future<void>.delayed(Duration.zero);

      expect(
        container.read(selectedVehicleProvider)?.currentMileage,
        12500,
      );
    });

    test('limpa a seleção quando o veículo é excluído do banco', () async {
      container.read(selectedVehicleProvider.notifier).select(_vehicle());

      vehiclesController.add([_vehicle(id: 2)]);
      await Future<void>.delayed(Duration.zero);

      expect(container.read(selectedVehicleProvider), isNull);
    });

    test('ignora eventos do banco quando nada está selecionado', () async {
      vehiclesController.add([_vehicle()]);
      await Future<void>.delayed(Duration.zero);

      expect(container.read(selectedVehicleProvider), isNull);
    });
  });
}
