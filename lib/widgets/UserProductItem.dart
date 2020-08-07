import 'package:Yummy/screens/EditProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Products.dart';

//if you want to see item widget,go to Your Products Screen
//build user sold products item
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
      {@required this.id, @required this.title, @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final productListner = Provider.of<Products>(context, listen: false);
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    productListner.deleteProduct(id);
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
