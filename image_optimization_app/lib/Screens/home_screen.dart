import 'package:flutter/material.dart';
import 'package:image_optimization_app/Screens/image_grid.dart';
import 'package:provider/provider.dart';
import 'package:image_optimization_app/Provider/image_op_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ImageOpProvider>(context, listen: false).compressImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageOpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Optimizer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              provider.clearCache();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared successfully')),
                );
              }
            },
            tooltip: 'Clear Cache',
          ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () async {
              await provider.pickAndCompressImage();
            },
            tooltip: 'Compress Image',
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<ImageOpProvider>(
            builder: (context, prov, child) {
              if (prov.compressedFile != null) {
                return _buildCompressionInfo(prov);
              }
              return const SizedBox.shrink();
            },
          ),
          const Expanded(child: ImageGrid()),
        ],
      ),
    );
  }

  Widget _buildCompressionInfo(ImageOpProvider provider) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Image Compressed!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => provider.resetCompression(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (provider.thumbnailFile != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                provider.thumbnailFile!,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            '${(provider.originalSize / 1024).toStringAsFixed(1)} KB',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            'Thumbnail created\nImage optimized',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
