import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_optimization_app/Model/compress_info_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  //compress image
  static Future<File> compressImage(File file, int quality) async {
    final directory = await getTemporaryDirectory();
    final targetPath =
        '${directory.path}/compressed_${DateTime.now().microsecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: quality,
      minWidth: 800,
      minHeight: 600,
      format: CompressFormat.jpeg,
    );
    if (result == null) {
      throw Exception('Error compressing image');
    } else {
      return File(result.path);
    }
  }

  //create thumbnail
  static Future<File> createThumbnail(File file, int width) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception('Error decoding image');
    }

    final thumbnail = img.copyResize(image, width: 150);
    final thumbnailBytes = img.encodeJpg(thumbnail);

    final directory = await getTemporaryDirectory();
    final thumbnailPath =
        '${directory.path}/thumbnail_${DateTime.now().microsecondsSinceEpoch}.jpg';
    final thumbnailFile = await File(
      thumbnailPath,
    ).writeAsBytes(thumbnailBytes);
    return thumbnailFile;
  }

  // pick image from gallery and compress it

  static Future<CompressedImageResult> pickAndCompressImage() async {
    int originalSize = 0;
    int compressedSize = 0;
    int thumbnailSize = 0;
    File compressedFile;
    File thumbnailFile;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      originalSize = await file.length();
      compressedFile = await compressImage(file, 80);
      compressedSize = await compressedFile.length();
      thumbnailFile = await createThumbnail(file, 150);
      thumbnailSize = await thumbnailFile.length();
    } else {
      throw Exception('No image selected');
    }
    return CompressedImageResult(
      compressedFile: compressedFile,
      thumbnailFile: thumbnailFile,
      originalKB: originalSize / 1024,
      compressedKB: compressedSize / 1024,
      thumbnailKB: thumbnailSize / 1024,
    );
  }
}
