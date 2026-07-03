import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constants/app_constants.dart';
import '../models/maintenance_model.dart';
import '../models/vehicle_model.dart';

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
      [VehicleModelSchema, MaintenanceModelSchema],
      directory: dir.path,
      name: AppConstants.isarDbName,
    );

    return _instance!;
  }
}
