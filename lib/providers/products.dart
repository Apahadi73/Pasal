import 'dart:convert';

import 'package:Yummy/data/DummyProducts.dart';
import 'package:flutter/material.dart';
import "package:convert/convert.dart"; //offers tool for converting data
import "package:http/http.dart" as http;

import '../data/DummyProducts.dart';
import 'Product.dart';

class Products with ChangeNotifier {
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return ProductData.items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...ProductData.items];
  }

  List<Product> get favoriteItems {
    return ProductData.items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return ProductData.items.firstWhere((prod) => prod.id == id);
  }

//add product to the items list and returns future
  Future<void> addProduct(Product product) {
    //sending new product to the backend database server
    const url = 'https://flutter-update.firebaseio.com/products.json';
    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
      }),
    )
        .then((response) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      //adds new product to the local array stored in memory

      ProductData.items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    });
  }

  void updateProduct(String productId, Product newProduct) {
    final productIndex =
        ProductData.items.indexWhere((element) => element.id == productId);
    if (productIndex >= 0) {
      ProductData.items[productIndex] = newProduct;
    }
    notifyListeners();
  }

//remove product from the items list
  void deleteProduct(String producId) {
    ProductData.items.removeWhere((element) => element.id == producId);
    notifyListeners();
  }
}
