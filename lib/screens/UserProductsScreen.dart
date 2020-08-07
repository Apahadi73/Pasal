import 'package:Yummy/widgets/HomePageDrawer.dart';
import 'package:Yummy/widgets/UserProductItem.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../providers/Products.dart';

//Screen that manages user's products
class UserProductsScreen extends StatelessWidget {
  static const routeName = "/UserProductScreen";

  @override
  Widget build(BuildContext context) {
    final productsListner = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),
      drawer: Drawer(
        child: HomePageDrawer(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsListner.items.length,
          // builds individual product item from the product items obtained from productsListner
          itemBuilder: (context, index) => UserProductItem(
            id: productsListner.items[index].id,
            title: productsListner.items[index].title,
            price: productsListner.items[index].price,
            imageUrl: productsListner.items[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
