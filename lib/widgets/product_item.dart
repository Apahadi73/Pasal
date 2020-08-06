import 'package:Yummy/providers/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Container(
      height: 30,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          header: GridTileBar(
              leading: Text(
            "\$${product.price.toString()}",
            style: TextStyle(fontSize: 12, color: Colors.black),
          )),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          footer: Container(
            height: 35,
            child: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                ),
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                ),
                onPressed: () {
                  cart.addItems(product.id, product.price, product.title);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added item to the cart!"),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            cart.removeSingleItgem(product.id);
                          }),
                    ),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
