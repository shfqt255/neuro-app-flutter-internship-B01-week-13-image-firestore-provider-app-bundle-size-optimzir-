import 'package:flutter/material.dart';
import 'package:optimized_provider_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProductProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        if (!isLoading) {
          return SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}
