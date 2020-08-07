import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../providers/Cart.dart";

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    //can be deleted by swipping left
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //is a future that returns true or false
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content:
                      Text("Do you want to remove the item from the cart?"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No")),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("Yes")),
                  ],
                ));
      },
      onDismissed: (direction) =>
          {Provider.of<Cart>(context, listen: false).removeItem(productId)},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            color: Colors.grey[100],
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "\$$price",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                backgroundColor: Colors.green,
              ),
              // tileColor: Colors.grey[100],
              title: Text(title),
              subtitle: Text("Total: \$${price * quantity}"),
              trailing: Text("$quantity x"),
            ),
          ),
        ),
      ),
    );
  }
}
