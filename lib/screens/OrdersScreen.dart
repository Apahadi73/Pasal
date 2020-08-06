import 'package:Yummy/widgets/homePageDrawer.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'package:Yummy/providers/Orders.dart' show Orders;
import "../widgets/OrderItem.dart";

class OrdersScreen extends StatelessWidget {
  static final routeName = "/OrdersScreen";
  @override
  Widget build(BuildContext context) {
    final orderListner = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      drawer: HomePageDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(orderListner.orders[index]),
        itemCount: orderListner.orders.length,
      ),
    );
  }
}
