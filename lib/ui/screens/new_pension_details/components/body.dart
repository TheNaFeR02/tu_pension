import 'package:flutter/material.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/custom_surfix_icon.dart';
import 'package:tu_pension/ui/components/default_button.dart';
import 'package:tu_pension/ui/screens/details/components/color_dots.dart';
import 'pension_form.dart';
import 'top_rounded_container.dart';
import 'pension_images.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Pension pension = Pension(
    id: 1,
    images: [
      "assets/images/add-image.png",
      "assets/images/add-image.png",
      "assets/images/add-image.png",
      "assets/images/add-image.png",
      "assets/images/add-image.png",
    ],
    // colors: [],
    title: "Agrega un título",
    price: 0,
    description:
        "Esta es una descripción de ejemplo, la cual deberá ser reemplazada por una descripción real del producto …",
    rating: '0.0',
    isFavourite: true,
    isPopular: true,
  );
  String? title;
  List<String> previewImages = []; // Initialize with your initial data

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        PensionImages(
          pension: pension,
          updatePreviewImages: (List<String> updatedImages) {
            setState(() {
              previewImages = updatedImages;
            });
          },
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              PensionForm(
                pension: pension,
                images: previewImages,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
