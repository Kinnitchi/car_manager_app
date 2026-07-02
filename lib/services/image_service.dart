import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  ImageService._();

  /// Abre a galeria, salva a imagem escolhida numa pasta permanente
  /// do app e retorna o caminho salvo (ou null se o usuário cancelar).
  static Future<String?> pickAndSaveImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1200,
    );
    if (picked == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final vehiclesDir = Directory('${dir.path}/vehicle_photos');
    if (!await vehiclesDir.exists()) {
      await vehiclesDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(
      picked.path,
    ).copy('${vehiclesDir.path}/$fileName');

    return savedImage.path;
  }

  static Future<void> deleteImage(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
