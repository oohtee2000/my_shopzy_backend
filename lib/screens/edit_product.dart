import 'package:flutter/material.dart';
import 'package:shopzy_ecommerce_backend/models/product_model.dart';
import 'package:shopzy_ecommerce_backend/services/database_service.dart';
import 'package:shopzy_ecommerce_backend/services/storage_service.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import '/screens/screens.dart';
import '/controllers/controllers.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  EditProductScreen({Key? key, required this.product}) : super(key: key);

  final ProductController productController = Get.find();

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the product values
    productController.newProduct.value = {
      'id': product.id,
      'name': product.name,
      'category': product.category,
      'description': product.description,
      'imageUrl': product.imageUrl,
      // 'price': product.price,
      // 'quantity': product.quantity,
      'price': product.price?.toDouble(), // Convert to double
      'quantity': product.quantity?.toDouble(), // Convert to double
      'isRecommended': product.isRecommended,
      'isPopular': product.isPopular,
    };

    List<String> categories = [
      'Smoothies',
      'Soft Drinks',
      'Water',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          ImagePicker _picker = ImagePicker();
                          final XFile? _image = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No image was selected.'),
                              ),
                            );
                          }

                          if (_image != null) {
                            await storage.uploadImage(_image);
                            var imageUrl =
                            await storage.getDownloadURL(_image.name);

                            productController.newProduct.update(
                                'imageUrl', (_) => imageUrl,
                                ifAbsent: () => imageUrl);
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Change Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextFormField(
                'Product Name',
                'name',
                productController,
              ),
              _buildTextFormField(
                'Product Description',
                'description',
                productController,
              ),
              DropdownButtonFormField(
                value: product.category,
                iconSize: 20,
                decoration: const InputDecoration(hintText: 'Product Category'),
                items: categories.map(
                      (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  productController.newProduct.update(
                    'category',
                        (_) => value,
                    ifAbsent: () => value,
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildSlider(
                'Price',
                'price',
                productController,
                // productController.price,
                productController.price?.toDouble(),
              ),
              _buildSlider(
                'Quantity',
                'quantity',
                productController,
                // productController.quantity,
                productController.quantity?.toDouble(),
              ),
              const SizedBox(height: 10),
              _buildCheckbox(
                'Recommended',
                'isRecommended',
                productController,
                productController.isRecommended,
              ),
              _buildCheckbox(
                'Popular',
                'isPopular',
                productController,
                productController.isPopular,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try{
                      await database.updateField(product, 'name',
                          productController.newProduct['name']);
                      await database.updateField(product, 'category',
                          productController.newProduct['category']);
                      await database.updateField(product, 'description',
                          productController.newProduct['description']);
                      await database.updateField(product, 'imageUrl',
                          productController.newProduct['imageUrl']);
                      await database.updateField(product, 'price',
                          productController.newProduct['price']);
                      await database.updateField(product, 'quantity',
                          productController.newProduct['quantity'].toInt());
                      await database.updateField(product, 'isRecommended',
                          productController.newProduct['isRecommended']);
                      await database.updateField(product, 'isPopular',
                          productController.newProduct['isPopular']);

                      //Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product saved successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 100),
                        ),
                      );

                      // Navigate to product screen
                      // Navigator.pop(context);
                      // Navigator.pushReplacementNamed(context, '/product_screen');
                      Get.to(() => ProductsScreen());
                    }catch(error){
                      // Handle any error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error saving product: $error'),
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 200),
                        ),
                      );
                    }



                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCheckbox(
      String title,
      String name,
      ProductController productController,
      bool? controllerValue,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Checkbox(
          value: controllerValue ?? false,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
                  (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row _buildSlider(
      String title,
      String name,
      ProductController productController,
      double? controllerValue,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: controllerValue ?? 0,
            min: 0,
            max: title == 'Quantity' ? 100 : 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                    (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
      String hintText,
      String name,
      ProductController productController,
      ) {
    return TextFormField(
      initialValue: productController.newProduct[name],
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
              (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}
