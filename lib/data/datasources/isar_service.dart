import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constants/app_constants.dart';

/// Gerencia a instância única do Isar.
/// Os schemas serão adicionados conforme criarmos os Models (@collection).
class IsarService {
  IsarService._();

  static Isar? _instance;

  static Isar get instance {
    if (_instance == null) {
      throw StateError(
        'Isar não inicializado. Chame IsarService.init() antes do runApp().',
      );
    }
    return _instance!;
  }

  static Future<Isar> init() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [
        // Schemas serão adicionados aqui à medida que criarmos os models:
        // VehicleModelSchema,
        // MaintenanceModelSchema,
        // FuelModelSchema,
      ],
      directory: dir.path,
      name: AppConstants.isarDbName,
    );

    return _instance!;
  }
}
