import 'package:flutter/material.dart';
import 'package:optimized_provider_app/providers/product_provider.dart';
import 'package:optimized_provider_app/widgets/cart_icon.dart';
import 'package:optimized_provider_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().loadProducts();
    });
    _scrollController.addListener(_paginationLoader);
  }

  void _paginationLoader() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductProvider>().loadProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Optimized Provider'), actions: [CartIcon()]),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.products.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: provider.products.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < provider.products.length) {
                final product = provider.products[index];
                return ChangeNotifierProvider.value(
                  value: provider,
                  child: ProductCard(product: product),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
