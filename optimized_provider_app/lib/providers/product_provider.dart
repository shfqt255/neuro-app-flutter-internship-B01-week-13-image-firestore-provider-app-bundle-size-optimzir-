import 'package:flutter/material.dart';
import 'package:optimized_provider_app/model/product_model.dart';
import 'package:optimized_provider_app/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final List<ProductModel> _products = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _limit = 10;
  int _skip = 0;
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  Future<void> loadProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();
    try {
      final data = await _productService.fetchProducts(
        limit: _limit,
        skip: _skip,
      );
      final List Productjson = data['products'];
      final List<ProductModel> loadedProducts = Productjson.map(
        (json) => ProductModel.fromJson(json),
      ).toList();
      _products.addAll(loadedProducts);
      _skip += _limit;
      if (loadedProducts.length < _limit) {
        _hasMore = false;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
