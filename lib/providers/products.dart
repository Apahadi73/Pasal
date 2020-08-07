import 'package:Yummy/data/DummyProducts.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
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

  Product findById(Uuid id) {
    return ProductData.items.firstWhere((prod) => prod.id == id);
  }

//add product to the items list
  void addProduct(Product product) {
    //sending new product to the backend database server

    ProductData.items.add(product);
    notifyListeners();
  }

  void updateProduct(Uuid productId, Product newProduct) {
    final productIndex =
        ProductData.items.indexWhere((element) => element.id == productId);
    if (productIndex >= 0) {
      ProductData.items[productIndex] = newProduct;
    }
    notifyListeners();
  }

//remove product from the items list
  void deleteProduct(Uuid producId) {
    ProductData.items.removeWhere((element) => element.id == producId);
    notifyListeners();
  }
}
