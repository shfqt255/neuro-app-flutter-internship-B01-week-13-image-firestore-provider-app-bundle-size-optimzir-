import 'package:flutter/material.dart';
import 'package:optimized_firestore_app/Model/product_model.dart';
import 'package:optimized_firestore_app/Provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().initializeProducts();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<ProductProvider>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Optimized Firestore App")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: scrollController,
              itemCount:
                  provider.products.length + (provider.isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < provider.products.length) {
                  ProductModel product = provider.products[index];

                  return Card(
                    child: ListTile(
                      title: Text(product.title),

                      subtitle: Text("Price: ${product.price}"),

                      trailing: IconButton(
                        onPressed: () {
                          context
                              .read<ProductProvider>()
                              .incrementProductCounter(product.id.toString());
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  );
                }

                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
    );
  }
}
