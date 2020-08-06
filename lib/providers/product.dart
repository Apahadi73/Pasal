import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Product with ChangeNotifier {
  final Uuid id = Uuid();
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
