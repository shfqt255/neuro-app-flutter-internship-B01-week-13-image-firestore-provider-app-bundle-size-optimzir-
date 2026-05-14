import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_optimization_app/Model/compress_info_model.dart';
import 'package:provider/provider.dart';
import 'package:image_optimization_app/Provider/image_op_provider.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageOpProvider>(
      builder: (context, provider, child) {
        final displayedUrls = provider.imageUrls
            .take(provider.displayCount)
            .toList();

        // listens to the events
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                /*
            if user scrolls down and reaches near to the end then load more images.
            this is so smart because, before reaching to the exact or absolute end, 
            it will load more images.
            just like tiktok, instagram, etc. it is very instresting.*/
                notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent - 200) {
              provider.loadMore();
            }
            return false;
          },
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  /*
                  it is also very interesting
                  let we have 10 displayed urls, it will show 10 items and one circular
                  indicator at the end. 10 + 1 = 11
                  
                  */
                  itemCount:
                      displayedUrls.length + (provider.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= displayedUrls.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _buildImageCard(
                      displayedUrls[index],
                      index < provider.compressinfo.length
                          ? provider.compressinfo[index]
                          : null,
                    );
                  },
                ),
              ),
              /*
              let we have 30 urls, initially displayCount = 10, so it will show 10 items and one circular indicator.
              when i scroll down and reach near to the end, it will load more images. 
              displayCount = 20, so it will show 20 items and one circular indicator.
              and when reached the length of the image urls, it will show the linear progress bar at the end.
            
              */
              if (provider.displayCount < provider.imageUrls.length)
                LinearProgressIndicator(
                  value: provider.displayCount / provider.imageUrls.length,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageCard(String url, CompressedImageResult? compressionInfo) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 40),
                    SizedBox(height: 8),
                    Text('Failed to load', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              memCacheWidth: 300,
              memCacheHeight: 300,
              maxHeightDiskCache: 400,
              maxWidthDiskCache: 400,
            ),
          ),
          if (compressionInfo != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _infoRow('Original', compressionInfo.originalKB),
                  _infoRow('Compressed', compressionInfo.compressedKB),
                  _infoRow('Thumbnail', compressionInfo.thumbnailKB),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, double kb) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
        Text(
          '${kb.toStringAsFixed(1)} KB',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
