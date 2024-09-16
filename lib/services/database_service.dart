import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopzy_ecommerce_backend/models/models.dart' as shopzy;
import 'package:shopzy_ecommerce_backend/models/models.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<OrderStats>> getOrderStats() async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('order_stats')
        .orderBy('dateTime')
        .get();

    return snapshot.docs
        .asMap()
        .entries
        .map((entry) => shopzy.OrderStats.fromSnapshot(entry.value, entry.key))
        .toList();
  }

  Stream<List<shopzy.Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) => shopzy.Order.fromSnapshot(doc)).toList();
      },
    );
  }

  Stream<List<shopzy.Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map(
          (snapshot) {
        return snapshot.docs.map((doc) => shopzy.Order.fromSnapshot(doc)).toList();
      },
    );
  }

  Stream<List<shopzy.Product>> getProducts() {
    return _firebaseFirestore.collection('products').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) => shopzy.Product.fromSnapshot(doc)).toList();
      },
    );
  }

  Future<void> addProduct(shopzy.Product product) async{
    try {
      await _firebaseFirestore.collection('products').add(product.toMap());
    }
    catch(e){
      print('Error saving product: $e');
    }
  }

  Future<void> updateField(shopzy.Product product, String field, dynamic newValue) {
    return _firebaseFirestore.collection('products').where('id', isEqualTo: product.id).get().then((querySnapshot) {
      querySnapshot.docs.first.reference.update({field: newValue});
    });
  }

  Future<void> updateOrder(shopzy.Order order, String field, dynamic newValue) {
    return _firebaseFirestore.collection('orders').where('id', isEqualTo: order.id).get().then((querySnapshot) {
      querySnapshot.docs.first.reference.update({field: newValue});
    });
  }
}
