import 'package:Yummy/screens/OrdersScreen.dart';
import 'package:Yummy/screens/UserProductsScreen.dart';
import "package:flutter/material.dart";

class HomePageDrawer extends StatelessWidget {
  Widget _buildChipWidget(IconData icon, String title, Function onTapHandler) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Chip(
        backgroundColor: Colors.blue[200],
        label: Container(
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            title: Text(title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            onTap: onTapHandler,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Options"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          _buildChipWidget(
            Icons.shopping_cart_sharp,
            "Shopping",
            () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          _buildChipWidget(
            Icons.payment,
            "My Orders",
            () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          _buildChipWidget(
            Icons.shop,
            "Manage Products",
            () {
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
