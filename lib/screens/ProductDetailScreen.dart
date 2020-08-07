import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              child: Card(
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Price: \$${loadedProduct.price}",
              style: TextStyle(color: Colors.green, fontSize: 22),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.orange,
                  )),
              width: double.infinity,
              child: Text(
                "${loadedProduct.description}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
