import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/houseA_1.jpg",
      "assets/images/houseA_2.jpg",
      "assets/images/houseA_3.jpg",
      "assets/images/houseA_4.jpg",
      "assets/images/houseA_5.jpg",
    ],
    colors: [
      // Color(0xFFF6625E),
      // Color(0xFF836DB8),
      // Color(0xFFDECB9C),
      // Colors.white,
    ],
    title: "Zona Norte - Todo incluido",
    price: 2000,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/houseB_1.jpg",
      "assets/images/houseB_2.jpg",
      "assets/images/houseB_3.jpg",
    ],
    colors: [
      // Color(0xFFF6625E),
      // Color(0xFF836DB8),
      // Color(0xFFDECB9C),
      // Colors.white,
    ],
    title: "Un hogar que inspira",
    price: 1500.5,
    description: description,
    rating: 4.3,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/houseC_1.jpg",
      "assets/images/houseC_2.jpg",
      "assets/images/houseC_3.jpg",
      "assets/images/houseC_4.jpg",
      "assets/images/houseC_5.jpg",
      "assets/images/houseC_6.jpg",
    ],
    colors: [
      // Color(0xFFF6625E),
      // Color(0xFF836DB8),
      // Color(0xFFDECB9C),
      // Colors.white,
    ],
    title: "Cerca universidades y centros comerciales",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  // Product(
  //   id: 4,
  //   images: [
  //     "assets/images/wireless headset.png",
  //   ],
  //   colors: [
  //     Color(0xFFF6625E),
  //     Color(0xFF836DB8),
  //     Color(0xFFDECB9C),
  //     Colors.white,
  //   ],
  //   title: "Logitech Head",
  //   price: 20.20,
  //   description: description,
  //   rating: 4.1,
  //   isFavourite: true,
  // ),
];

const String description =
    "Esta es una descripción de ejemplo, la cual deberá ser reemplazada por una descripción real del producto …";
