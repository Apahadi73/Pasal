import "package:flutter/material.dart";
import "../providers/Cart.dart" show Cart;
import "package:provider/provider.dart";
import "../widgets/CartItem.dart";
import "../providers/Orders.dart";

class CartScreen extends StatelessWidget {
  static final routeName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    print(cart.totalAmount);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pasal"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    "\$${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            child: Chip(
                label: Text(
                  "ORDER NOW",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).accentColor),
            onPressed: () {
              Provider.of<Orders>(context, listen: false).addOrder(
                cart.totalAmount,
                cart.items.values.toList(),
              );
              cart.clearCart();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItem(
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price,
                  productId: cart.items.keys.toList()[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
