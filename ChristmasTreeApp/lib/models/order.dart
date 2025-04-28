import 'package:christmas_tree/models/orderitem.dart' show OrderItem;
import 'package:christmas_tree/models/stylistbooking.dart';

class Order {
  final int orderId;
  final int userId;
  final DateTime orderDate;
  final double totalAmount;
  final String status;
  final int shippingAddressId;
  final String paymentMethod;
  final List<OrderItem> orderItems;
  final StylistBooking? stylistBooking;

  Order({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.shippingAddressId,
    required this.paymentMethod,
    required this.orderItems,
    this.stylistBooking,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      shippingAddressId: json['shippingAddressId'],
      paymentMethod: json['paymentMethod'],
      orderItems: List<OrderItem>.from(
          json['orderItems'].map((x) => OrderItem.fromJson(x))),
      stylistBooking: json['stylistBooking'] != null
          ? StylistBooking.fromJson(json['stylistBooking'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'orderId': orderId,
    'userId': userId,
    'orderDate': orderDate.toIso8601String(),
    'totalAmount': totalAmount,
    'status': status,
    'shippingAddressId': shippingAddressId,
    'paymentMethod': paymentMethod,
    'orderItems': orderItems.map((item) => item.toJson()).toList(),
    'stylistBooking': stylistBooking?.toJson(),
  };
}
}
