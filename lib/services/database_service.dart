import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopzy_ecommerce_backend/models/models.dart' as shopzy; // Use alias

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firebaseFirestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  Stream<List<shopzy.Order>> getOrders() { // Use alias here
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => shopzy.Order.fromSnapshot(doc)).toList(); // Use alias here
    });
  }

  Stream<List<shopzy.Order>> getPendingOrders() { // Use alias here
    return _firebaseFirestore
        .collection('orders')
        .where('isCancelled', isEqualTo: false)
        .where('isDelivered', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => shopzy.Order.fromSnapshot(doc)).toList(); // Use alias here
    });
  }

  Stream<List<shopzy.Product>> getProducts() { // Use alias here
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => shopzy.Product.fromSnapshot(doc)).toList(); // Use alias here
    });
  }

  Future<List<shopzy.OrderStats>> getOrderStats() async { // Use alias here
    try {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('order_stats')
          .orderBy('dateTime')
          .get();

      return snapshot.docs
          .asMap()
          .entries
          .map((entry) => shopzy.OrderStats.fromSnapshot(entry.value, entry.key)) // Use alias here
          .toList();
    } catch (e) {
      print('Error fetching order stats: $e');
      return [];
    }
  }

  Future<void> addProduct(shopzy.Product product) async { // Use alias here
    // print(product);
    try {
      await _firebaseFirestore.collection('products').add(product.toMap());
    } catch (e) {
      print('Error saving product: $e');
    }
  }


  // Future<void> addProduct(shopzy.Product product) async {
  //   try {
  //     await _firebaseFirestore.collection('products').add(product.toMap());
  //     print("Product added successfully");
  //   } catch (e) {
  //     print("Error adding product: $e");
  //   }
  // }




  Future<void> updateField(
      shopzy.Product product,
      String field,
      dynamic newValue,
      ) async { // Use alias here
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('products')
          .where('id', isEqualTo: product.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({field: newValue});
      }
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  Future<void> updateOrder(
      shopzy.Order order,
      String field,
      dynamic newValue,
      ) async { // Use alias here
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('orders')
          .where('id', isEqualTo: order.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({field: newValue});
      }
    } catch (e) {
      print('Error updating order: $e');
    }
  }
}
