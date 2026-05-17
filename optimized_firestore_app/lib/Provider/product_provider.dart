import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optimized_firestore_app/Model/product_model.dart';
import 'package:optimized_firestore_app/Services/api_service.dart';
import 'package:optimized_firestore_app/services/firestore_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService apiService;
  final FirestoreService firestoreService;

  ProductProvider({required this.apiService, required this.firestoreService});

  List<ProductModel> products = [];

  bool isLoading = false;
  bool isFetchingMore = false;

  final int limit = 10;

  int skip = 0;

  bool hasMore = true;

  DocumentSnapshot? lastDocument;
  Future<void> initializeProducts() async {
    isLoading = true;
    notifyListeners();
    final apiProducts = await apiService.fetchProducts(
      limit: limit,
      skip: skip,
    );
    await firestoreService.saveProducts(apiProducts);

    await loadProducts();

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    if (!hasMore) return;

    final snapshot = await firestoreService.getProducts(
      limit: limit,
      lastDocument: lastDocument,
    );

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;

      List<ProductModel> newProducts = snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      products.addAll(newProducts);
    }

    if (snapshot.docs.length < limit) {
      hasMore = false;
    }

    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isFetchingMore || !hasMore) return;

    isFetchingMore = true;
    notifyListeners();

    skip += limit;
    final apiProducts = await apiService.fetchProducts(
      limit: limit,
      skip: skip,
    );

    if (apiProducts.isEmpty) {
      hasMore = false;

      isFetchingMore = false;
      notifyListeners();
      return;
    }

    await firestoreService.saveProducts(apiProducts);

    await loadProducts();

    isFetchingMore = false;

    notifyListeners();
  }

  Future<void> incrementProductCounter(String docId) async {
    await firestoreService.incrementCounter(docId);
  }
}
