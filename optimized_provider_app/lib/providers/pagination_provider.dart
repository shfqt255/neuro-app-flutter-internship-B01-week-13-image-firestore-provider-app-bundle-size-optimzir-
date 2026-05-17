import 'package:flutter/material.dart';

class PaginationProvider extends ChangeNotifier {
  bool _hasMore = false;

  bool get hasMore => _hasMore;

  void setHasMore(bool value) {
    if (hasMore == value) return;
    _hasMore = value;
    notifyListeners();
  }
}
