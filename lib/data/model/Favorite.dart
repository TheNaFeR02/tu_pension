import 'package:flutter/material.dart';

import 'Product.dart';

class Favorite {
  final Product product;
  // final int numOfItem;

  Favorite({required this.product});
}

// Demo data for our favorite

List<Favorite> demoFavorites = [
  Favorite(product: demoProducts[0]),
  Favorite(product: demoProducts[1]),
  Favorite(product: demoProducts[2]),
  Favorite(product: demoProducts[0]),
  Favorite(product: demoProducts[1]),
  Favorite(product: demoProducts[2]),
];
