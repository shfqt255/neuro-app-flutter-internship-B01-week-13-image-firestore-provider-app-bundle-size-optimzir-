import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  Future<Map<String, dynamic>> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
