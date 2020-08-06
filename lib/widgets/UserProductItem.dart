import 'package:Yummy/screens/EditProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//if you want to see item widget,go to Your Products Screen
//build user sold products item
class UserProductItem extends StatelessWidget {
  final Uuid id = Uuid(); //this gives universally unique identifier for each object we create
  final String title;
  final double price;
  final String imageUrl;

  UserProductItem({@required this.title, @required this.price, @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pushNamed(EditProductScreen.routeName);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
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
