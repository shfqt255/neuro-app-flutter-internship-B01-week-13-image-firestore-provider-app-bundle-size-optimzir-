import 'dart:io';

class CompressedImageResult {
  final File compressedFile;
  final File thumbnailFile;
  final double originalKB;
  final double compressedKB;
  final double thumbnailKB;

  CompressedImageResult({
    required this.compressedFile,
    required this.thumbnailFile,
    required this.originalKB,
    required this.compressedKB,
    required this.thumbnailKB,
  });
}
