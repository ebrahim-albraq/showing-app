import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart ' as http;
import '../providers/products.dart';
class Product  with ChangeNotifier{

  final String id;
  final String title;
  final String description;
  double price;
  final String imageUrl;
  bool isFavorite;



  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();

    Future<void> toggleFavoriteStatus(String token, String userId) async {
      final oldStatus = !isFavorite;
      notifyListeners();
      final url =
          'https://shoping-b27aa-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

      try {
        final res = await http.put(url, body: json.encode(isFavorite));
        if (res.statusCode >= 400) {
          _setFavValue(oldStatus);
        }
      }
      catch (e) {
        _setFavValue(oldStatus);
      }
    }
  }

}