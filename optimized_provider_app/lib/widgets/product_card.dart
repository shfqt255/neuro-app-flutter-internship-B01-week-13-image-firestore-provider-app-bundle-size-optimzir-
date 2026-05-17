import 'package:flutter/material.dart';
import 'package:optimized_provider_app/model/product_model.dart';
import 'package:optimized_provider_app/providers/cart_provider.dart';
import 'package:optimized_provider_app/utils/performance_logger.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    PerformanceLogger.logRebuild('ProductCard');
    return Card(
      child: ListTile(
        title: Text(product.title),
        subtitle: Text(product.price.toString()),
        trailing: Consumer<CartProvider>(
          builder: (context, provider, child) {
            return IconButton(
              onPressed: () => provider.toggleCart(product.id),
              icon: Icon(
                provider.cartItems.contains(product.id)
                    ? Icons.remove
                    : Icons.add,
              ),
            );
          },
        ),
      ),
    );
  }
}
