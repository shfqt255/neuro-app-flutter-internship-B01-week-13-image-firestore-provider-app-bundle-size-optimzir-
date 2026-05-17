import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:optimized_firestore_app/Model/product_model.dart';

class ApiService {
  Future<List<ProductModel>> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List products = data['products'];

      return products.map((e) {
        return ProductModel(
          id: e['id'],
          title: e['title'],
          price: (e['price']).toDouble(),
          stock: e['stock'],
          tags: e['tags'] ?? [],
          counter: 0,
        );
      }).toList();
    } else {
      throw Exception("Failed To Fetch Products");
    }
  }
}
