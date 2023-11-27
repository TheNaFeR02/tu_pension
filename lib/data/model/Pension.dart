import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pension {
  String? key;
  String title, description, rating, sellerUid;
  List<String> images;
  int price;
  bool? isFavourite, isPopular;

  Pension({
    required this.images,
    // required this.colors,
    this.rating = '0.0',
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.sellerUid,
  });

  Pension.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? "0",
        title = json['title'] ?? "title",
        description = json['description'] ?? "description",
        price = json['price'] ?? 0,
        images = List<String>.from(json['images'] ?? []),
        rating = json['rating'] ?? '0.0',
        sellerUid = json['uid'] ?? "";

  toJson() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "images": images,
      // "rating": rating,
      "sellerUid": sellerUid,
    };
  }

  // @override
  String toString() {
    return 'Pension{id: $key, title: $title}';
  }
}

// Our demo Products

List<Pension> demoProducts = [
  Pension(
    sellerUid: "0",
    images: [
      "assets/images/houseA_1.jpg",
      "assets/images/houseA_2.jpg",
      "assets/images/houseA_3.jpg",
      "assets/images/houseA_4.jpg",
      "assets/images/houseA_5.jpg",
    ],
    // colors: [
    //   // Color(0xFFF6625E),
    //   // Color(0xFF836DB8),
    //   // Color(0xFFDECB9C),
    //   // Colors.white,
    // ],
    title: "Zona Norte - Todo incluido",
    price: 2000,
    description: description,
    rating: '4.8',
    isFavourite: true,
    isPopular: true,
  ),
  Pension(
    sellerUid: "1",
    images: [
      "assets/images/houseB_1.jpg",
      "assets/images/houseB_2.jpg",
      "assets/images/houseB_3.jpg",
    ],
    // colors: [
    //   // Color(0xFFF6625E),
    //   // Color(0xFF836DB8),
    //   // Color(0xFFDECB9C),
    //   // Colors.white,
    // ],
    title: "Un hogar que inspira",
    price: 1500,
    description: description,
    rating: '4.3',
    isPopular: true,
  ),
  Pension(
    sellerUid: "2",
    images: [
      "assets/images/houseC_1.jpg",
      "assets/images/houseC_2.jpg",
      "assets/images/houseC_3.jpg",
      "assets/images/houseC_4.jpg",
      "assets/images/houseC_5.jpg",
      "assets/images/houseC_6.jpg",
    ],
    // colors: [
    //   // Color(0xFFF6625E),
    //   // Color(0xFF836DB8),
    //   // Color(0xFFDECB9C),
    //   // Colors.white,
    // ],
    title: "Cerca universidades y centros comerciales",
    price: 36,
    description: description,
    rating: '4.1',
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
