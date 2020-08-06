import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final Uuid id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<Uuid, CartItem> _items = {};

  Map<Uuid, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int counts = 0;
    _items.forEach((key, cartitem) {
      counts += cartitem.quantity;
    });
    return counts;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void addItems(Uuid productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (v) => CartItem(
                id: v.id,
                title: v.title,
                price: v.price,
                quantity: v.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: Uuid(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(Uuid productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItgem(Uuid productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      // since _items is a map/dictionary
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));
    } else {
      // if cartitem quantity is 1, then we should remove it from the cart
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
