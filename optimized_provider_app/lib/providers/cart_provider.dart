import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<int> _cartItems = [];
  List<int> get cartItems => _cartItems;

  void addToCart(int productId) {
    if (!_cartItems.contains(productId)) {
      _cartItems.add(productId);
      notifyListeners();
    } else {
      debugPrint('Item already in cart');
    }
  }

  void removeFromCart(int productId) {
    if (_cartItems.contains(productId)) {
      _cartItems.remove(productId);
      notifyListeners();
    } else {
      debugPrint('Item not in cart');
    }
  }

  void toggleCart(int id) {
    if (_cartItems.contains(id)) {
      removeFromCart(id);
    } else {
      addToCart(id);
    }
  }
}
