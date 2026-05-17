import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimized_firestore_app/Model/product_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveProducts(List<ProductModel> products) async {
    WriteBatch batch = firestore.batch();

    for (var product in products) {
      final docRef = firestore
          .collection('products')
          .doc(product.id.toString());

      batch.set(docRef, {
        ...product.toMap(),
        "counter": FieldValue.increment(1),
        "createdAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    await batch.commit();
  }

  Future<QuerySnapshot> getProducts({
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = firestore.collection('products').orderBy('id').limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return await query.get();
  }

  Future<void> incrementCounter(String docId) async {
    await firestore.collection('products').doc(docId).update({
      "counter": FieldValue.increment(1),
    });
  }
}
