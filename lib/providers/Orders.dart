import 'package:flutter/material.dart';
import "./Cart.dart";

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(double cartTotal, List<CartItem> cartProducts) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: cartTotal,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
    notifyListeners();
  }
}
