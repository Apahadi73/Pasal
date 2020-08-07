import 'package:Yummy/screens/OrdersScreen.dart';
import 'package:Yummy/screens/UserProductsScreen.dart';
import "package:flutter/material.dart";

class HomePageDrawer extends StatelessWidget {
  Widget _buildChipWidget(IconData icon, String title, Function onTapHandler,
      BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Color(0xff80D0C7), Color(0xff0093E9)])),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: RaisedButton(
        // hoverColor: Theme.of(context).primaryColorDark,//no effect when using as mobile app
        child: Container(
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
            onLongPress: onTapHandler,
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
          _buildChipWidget(Icons.shopping_cart, "Shopping", () {
            Navigator.of(context).pushReplacementNamed("/");
          }, context),
          Divider(),
          _buildChipWidget(Icons.payment, "My Orders", () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          }, context),
          Divider(),
          _buildChipWidget(Icons.shop, "Manage Products", () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
