import 'dart:convert'; // Needed for json.encode and json.decode
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productsIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isCancelled;
  final bool isDelivered;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.productsIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
    required this.createdAt,
  });

  Order copyWith({
    int? id,
    int? customerId,
    List<int>? productsIds,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productsIds: productsIds ?? this.productsIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Empty merge method
  Order merge(Order model) {
    return copyWith(
      id: model.id,
      customerId: model.customerId,
      productsIds: model.productsIds,
      deliveryFee: model.deliveryFee,
      subtotal: model.subtotal,
      total: model.total,
      isAccepted: model.isAccepted,
      isDelivered: model.isDelivered,
      isCancelled: model.isCancelled,
      createdAt: model.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productsIds': productsIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      customerId: map['customerId'],
      productsIds: List<int>.from(map['productsIds']),
      deliveryFee: map['deliveryFee'],
      subtotal: map['subtotal'],
      total: map['total'],
      isAccepted: map['isAccepted'],
      isDelivered: map['isDelivered'],
      isCancelled: map['isCancelled'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    return Order(
      id: snap['id'],
      customerId: snap['customerId'],
      productsIds: List<int>.from(snap['productsIds']),
      deliveryFee: snap['deliveryFee'],
      subtotal: snap['subtotal'],
      total: snap['total'],
      isAccepted: snap['isAccepted'],
      isDelivered: snap['isDelivered'],
      isCancelled: snap['isCancelled'],
      createdAt: (snap['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      productsIds,
      deliveryFee,
      subtotal,
      total,
      isAccepted,
      isDelivered,
      isCancelled,
      createdAt,
    ];
  }

  static List<Order> orders = [
    Order(
      id: 1,
      customerId: 2345,
      productsIds: const [1, 2],
      deliveryFee: 10.0,
      subtotal: 20.0,
      total: 30.0,
      isAccepted: false,
      isDelivered: false,
      isCancelled: true,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 2,
      customerId: 3456,
      productsIds: const [3, 4],
      deliveryFee: 8.0,
      subtotal: 25.0,
      total: 33.0,
      isAccepted: true,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 3,
      customerId: 4567,
      productsIds: const [5, 6, 7],
      deliveryFee: 5.0,
      subtotal: 40.0,
      total: 45.0,
      isAccepted: true,
      isDelivered: true,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 4,
      customerId: 5678,
      productsIds: const [8, 9],
      deliveryFee: 12.0,
      subtotal: 30.0,
      total: 42.0,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 5,
      customerId: 6789,
      productsIds: const [10, 11, 12],
      deliveryFee: 7.0,
      subtotal: 35.0,
      total: 42.0,
      isAccepted: true,
      isDelivered: true,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
  ];
}
