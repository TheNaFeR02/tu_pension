import 'package:firebase_database/firebase_database.dart';

class UserPension {
  String? key;
  String title;
  String description;
  String price;
  List<String> images;

  UserPension(this.key, this.title, this.description, this.price, this.images);

  UserPension.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? "0",
        title = json['title'] ?? "title",
        description = json['description'] ?? "description",
        price = json['price'] ?? 0,
        images = List<String>.from(json['images'] ?? []);

  toJson() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "images": images,
    };
  }
}
