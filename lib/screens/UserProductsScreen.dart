import 'package:Yummy/widgets/HomePageDrawer.dart';
import 'package:Yummy/widgets/UserProductItem.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../providers/Products.dart';
import 'EditProductScreen.dart';

//Screen that manages user's products aka manage products route screen
class UserProductsScreen extends StatelessWidget {
  static const routeName = "/UserProductScreen";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: HomePageDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              // builds individual product item from the product items obtained from productsListner
              UserProductItem(
                id: productsData.items[i].id,
                title: productsData.items[i].title,
                imageUrl: productsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
