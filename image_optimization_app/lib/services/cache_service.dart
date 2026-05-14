import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static final DefaultCacheManager _cacheManager = DefaultCacheManager();

  static Future<void> clearCache() async {
    await _cacheManager.emptyCache();
    await CachedNetworkImage.evictFromCache('');
  }

  static Future<Map<String, dynamic>> getcacheinfo() async {
    final store = await _cacheManager.getFileFromCache('');

    return {
      'fileCount': store?.file.length ?? 0,
      'memoryUsage': await store?.file.length() ?? 0,
    };
  }
}
