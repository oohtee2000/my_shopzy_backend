import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Product extends Equatable {
  final int? id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  double price;
  int quantity;

  Product({
   this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isRecommended,
    required this.isPopular,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    description,
    imageUrl,
    isRecommended,
    isPopular,
    price,
    quantity,
  ];

  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    bool? isRecommended,
    bool? isPopular,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Firestore can generate an id for you if you don't provide one
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity,
    };
  }


  // factory Product.fromSnapshot(DocumentSnapshot snap) {
  //   var data = snap.data() as Map<String, dynamic>;
  //
  //   return Product(
  //     id: (data['id'] ).toInt() ?? 0,
  //     name: data['name'] ?? 'Unknown',
  //     category: data['category'] ?? 'Uncategorized',
  //     description: data['description'] ?? 'No description',
  //     imageUrl: data['imageUrl'] ?? '',
  //     isRecommended: data['isRecommended'] ?? false,
  //     isPopular: data['isPopular'] ?? false,
  //     price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
  //     quantity: (data['quantity'] is num) ? (data['quantity'] as num).toInt() : 0, // Convert to int safely
  //
  //   );
  // }


  factory Product.fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return Product(
      id: (data['id'] as int?) ?? 0, // Change made here
      name: data['name'] ?? 'Unknown',
      category: data['category'] ?? 'Uncategorized',
      description: data['description'] ?? 'No description',
      imageUrl: data['imageUrl'] ?? '',
      isRecommended: data['isRecommended'] ?? false,
      isPopular: data['isPopular'] ?? false,
      price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
      quantity: (data['quantity'] is num) ? (data['quantity'] as num).toInt() : 0, // Ensure it's an int or provide a default
    );
  }





  String toJson() => json.encode(toMap());



  @override
  bool get stringify => true;

  static List<Product> products = [
    Product(
      id: 1,
      name: 'Soft Drink #1',
      category: 'Soft Drink',
      description: 'A refreshing soft drink.',
      imageUrl:
      'https://cdn.pixabay.com/photo/2013/03/01/18/48/aluminum-87987_1280.jpg',
      price: 2.99,
      quantity: 12,
      isRecommended: true,
      isPopular: false,
    ),
    Product(
      id: 2,
      name: 'Soft Drink #2',
      category: 'Soft Drink',
      description: 'A popular soda choice.',
      imageUrl:
      'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
      price: 2.99,
      quantity: 12,
      isRecommended: true,
      isPopular: false,
    ),
    Product(
      id: 3,
      name: 'Soft Drink #3',
      category: 'Soft Drink',
      description: 'A classic beverage.',
      imageUrl:
      'https://cdn.pixabay.com/photo/2015/09/05/20/31/soda-925129_1280.jpg',
      price: 2.99,
      quantity: 12,
      isRecommended: true,
      isPopular: false,
    ),
    Product(
      id: 4,
      name: 'Smoothies #1',
      category: 'Smoothies',
      description: 'A delicious smoothie drink.',
      imageUrl:
      'https://cdn.pixabay.com/photo/2020/04/03/10/57/smoothie-4998381_1280.jpg',
      price: 2.99,
      quantity: 12,
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      id: 5,
      name: 'Smoothies #2',
      category: 'Smoothies',
      description: 'A fruity and healthy drink.',
      imageUrl:
      'https://cdn.pixabay.com/photo/2015/04/16/13/25/cocktail-725575_1280.jpg',
      price: 2.99,
      quantity: 12,
      isRecommended: false,
      isPopular: false,
    ),
  ];
}