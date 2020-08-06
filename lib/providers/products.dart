import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        title: 'iPhone X',
        description: 'A new iPhone with redesigned form factor',
        price: 799,
        imageUrl: "https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
    Product(
      title: 'Macbook',
      description:
          "The incredibly thin and light MacBook Air is now more powerful than ever. It features a brilliant Retina display, new Magic Keyboard, Touch ID, processors with up to twice the performance,1 faster graphics, and double the storage capacity. The sleek wedge-shaped design is created from 100 percent recycled aluminum, making it the greenest Mac ever.2 And with all-day battery life, our most popular Mac is your perfectly portable, do-it-all notebook.",
      price: 999,
      imageUrl: "https://images.unsplash.com/photo-1477327070293-75f15e291bb0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
    ),
    Product(
      title: 'Mac Mini',
      description:
          'In addition to being a great desktop computer, Mac mini powers everything from home automation to giant render farms. And now with eighth-generation Intel quad-core and 6-core processors and Intel UHD Graphics 630, Mac mini has even more compute power for industrial-grade tasks. So whether you’re running a live concert sound engine or testing your latest iOS or iPadOS app, Mac mini is the shortest distance between a great idea and a great result.',
      price: 799.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2017/04/04/17/20/mac-2202256_960_720.jpg',
    ),
    Product(
        title: 'iPad',
        description: '''It’s a magical piece of glass.
        It’s so fast most PC laptops can’t catch up.
        It has pro cameras that can transform reality.
        And you can use it with touch, pencil, keyboard, and now trackpad.
        It’s the new iPad Pro.''',
        price: 49.99,
        imageUrl: "https://images.unsplash.com/photo-1543069190-f687504216a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80"),
    Product(
      title: 'XPS 15',
      description: "A great laptop.",
      price: 1799.99,
      imageUrl: 'https://images.unsplash.com/photo-1575320854760-bfffc3550640?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80',
    ),
    Product(
        title: 'Logitech ',
        description: " A great mouse.",
        price: 99.99,
        imageUrl: "https://images.unsplash.com/photo-1586349906319-48d20e9d17e5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(Uuid id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
