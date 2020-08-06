import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "dart:math";

import "../providers/Orders.dart" as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final productsList = widget.orderItem.products;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("\$${widget.orderItem.amount}"),
            subtitle: Text(DateFormat("dd MM yyyy hh:mm").format(widget.orderItem.dateTime)),
            trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                }),
          ),
          if (_isExpanded)
            Container(
              height: min(productsList.length * 15.0 + 100, 180),
              child: ListView.builder(
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        productsList[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${productsList[index].quantity}x \$${productsList[index].price}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
