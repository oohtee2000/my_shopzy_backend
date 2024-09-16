import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrderStats {
  final DateTime dateTime;
  final int index;
  final int orders;
  Color barColor;

  OrderStats({
    required this.dateTime,
    required this.index,
    required this.orders,  // Corrected from 'order' to 'orders'
    Color? barColor,       // fl_chart Color type
  }) : barColor = barColor ?? Colors.black;  // Use Colors.black by default

  factory OrderStats.fromSnapshot(DocumentSnapshot snap, int index){
    return OrderStats(
        dateTime: snap['dateTime'].toDate(),
        index: index,
        orders: snap['orders']);
  }
  static final List<OrderStats> data = [
    OrderStats(
      dateTime: DateTime.now(),
      index: 0,
      orders: 10,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 1)),
      index: 1,
      orders: 15,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 2)),
      index: 2,
      orders: 12,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 3)),
      index: 3,
      orders: 20,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 4)),
      index: 4,
      orders: 18,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 5)),
      index: 5,
      orders: 22,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 6)),
      index: 6,
      orders: 9,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 7)),
      index: 7,
      orders: 14,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 8)),
      index: 8,
      orders: 16,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 9)),
      index: 9,
      orders: 19,
    ),
    OrderStats(
      dateTime: DateTime.now().subtract(Duration(days: 10)),
      index: 10,
      orders: 11,
    ),
  ];
}
