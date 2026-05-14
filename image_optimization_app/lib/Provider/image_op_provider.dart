import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_optimization_app/Model/compress_info_model.dart';
import 'package:image_optimization_app/services/cache_service.dart';
import 'package:image_optimization_app/services/image_service.dart';
import 'package:path_provider/path_provider.dart';

class ImageOpProvider extends ChangeNotifier {
  bool _isLoading = false;
  int _displayCount = 10;
  int originalSize = 0;
  int compressedSize = 0;
  int thumbnailSize = 0;

  List<CompressedImageResult> compressinfo = [];
  final List<String> _imageUrls = [
    'https://picsum.photos/seed/1/1000/800',
    'https://picsum.photos/seed/2/1000/800',
    'https://picsum.photos/seed/3/1000/800',
    'https://picsum.photos/seed/4/1000/800',
    'https://picsum.photos/seed/5/1000/800',
    'https://picsum.photos/seed/6/1000/800',
    'https://picsum.photos/seed/7/1000/800',
    'https://picsum.photos/seed/8/1000/800',
    'https://picsum.photos/seed/9/1000/800',
    'https://picsum.photos/seed/10/1000/800',
    'https://picsum.photos/seed/11/1000/800',
    'https://picsum.photos/seed/12/1000/800',
    'https://picsum.photos/seed/13/1000/800',
    'https://picsum.photos/seed/14/1000/800',
    'https://picsum.photos/seed/15/1000/800',
    'https://picsum.photos/seed/16/1000/800',
    'https://picsum.photos/seed/17/1000/800',
    'https://picsum.photos/seed/18/1000/800',
    'https://picsum.photos/seed/19/1000/800',
    'https://picsum.photos/seed/20/1000/800',
    'https://picsum.photos/seed/21/1000/800',
    'https://picsum.photos/seed/22/1000/800',
    'https://picsum.photos/seed/23/1000/800',
    'https://picsum.photos/seed/24/1000/800',
    'https://picsum.photos/seed/25/1000/800',
    'https://picsum.photos/seed/26/1000/800',
    'https://picsum.photos/seed/27/1000/800',
    'https://picsum.photos/seed/28/1000/800',
    'https://picsum.photos/seed/29/1000/800',
    'https://picsum.photos/seed/30/1000/800',
  ];
  bool get isLoading => _isLoading;
  int get displayCount => _displayCount;
  List<String> get imageUrls => _imageUrls;
  File? _thumbnailFile;
  File? _compressedFile;
  File? get compressedFile => _compressedFile;
  File? get thumbnailFile => _thumbnailFile;
  //load more
  void loadMore() {
    if (!_isLoading && _displayCount < _imageUrls.length) {
      _isLoading = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 500), () {
        _displayCount = (_displayCount + 10).clamp(
          _displayCount,
          _imageUrls.length,
        );
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  // compress images
  Future<void> compressImages() async {
    _isLoading = true;
    notifyListeners();
    final tempDir = await getTemporaryDirectory();
    for (int i = 0; i < _imageUrls.length; i++) {
      // Download the image from the URL into temp file
      final response = await http.get(Uri.parse(_imageUrls[i]));
      final tempFile = File('${tempDir.path}/original_$i.jpg');
      await tempFile.writeAsBytes(response.bodyBytes);

      originalSize = tempFile.lengthSync();
      final compressedFile = await ImageService.compressImage(tempFile, 80);
      final thumbnailFile = await ImageService.createThumbnail(tempFile, 150);
      _compressedFile = compressedFile;
      _thumbnailFile = thumbnailFile;

      final compressedSize = await compressedFile.length();
      final thumbnailSize = await thumbnailFile.length();

      compressinfo.add(
        CompressedImageResult(
          compressedFile: compressedFile,
          thumbnailFile: thumbnailFile,
          originalKB: originalSize / 1024,
          compressedKB: compressedSize / 1024,
          thumbnailKB: thumbnailSize / 1024,
        ),
      );
      notifyListeners(); // update UI as each image completes
    }
    _isLoading = false;
    notifyListeners();
  }

  // reset compression
  void resetCompression() {
    _thumbnailFile = null;
    _compressedFile = null;
    notifyListeners();
  }

  // pick and compress image
  Future<void> pickAndCompressImage() async {
    _isLoading = true;
    notifyListeners();

    final result = await ImageService.pickAndCompressImage();

    _compressedFile = result.compressedFile;
    _thumbnailFile = result.thumbnailFile;

    _isLoading = false;
    notifyListeners();
  }

  // clear cache
  void clearCache() {
    CacheService.clearCache();
    notifyListeners();
  }
}
