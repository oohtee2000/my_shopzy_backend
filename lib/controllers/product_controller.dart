import 'package:shopzy_ecommerce_backend/models/models.dart';
import 'package:shopzy_ecommerce_backend/services/database_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  var products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }


  void deleteProduct(String productId) async {
    try {
      // Log before deletion
      print('Attempting to delete product with ID: $productId');

      // Delete from Firestore
      await database.deleteDocument('products', productId);

      // Log after Firestore deletion attempt
      print('Deleted product from Firestore');

      // Remove from local observable list
      products.removeWhere((product) => product.id == productId);

      // Trigger update to notify observers
      update();  // Ensure UI updates

      // Log after removing from local list
      print('Product removed from local list');

      // Show success message
      Get.snackbar(
        'Success',
        'Product deleted Successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Log any error that happens during deletion
      print('Error deleting product: $e');

      Get.snackbar(
        'Error',
        'Failed to delete product: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



  void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }

  void saveNewProductQuantity(
    Product product,
    String field,
    int value,
  ) {
    database.updateField(product, field, value);
  }
}
