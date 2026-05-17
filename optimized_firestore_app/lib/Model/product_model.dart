class ProductModel {
  final int id;
  final String title;
  final double price;
  final int stock;
  final List<dynamic> tags;
  final int counter;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.tags,
    required this.counter,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
      tags: map['tags'] ?? [],
      counter: map['counter'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "stock": stock,
      "tags": tags,
      "counter": counter,
    };
  }
}
