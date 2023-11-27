import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';

class PensionImages extends StatefulWidget {
  const PensionImages({
    Key? key,
    required this.pension,
  }) : super(key: key);

  final Pension pension;

  @override
  _PensionImagesState createState() => _PensionImagesState();
}

class _PensionImagesState extends State<PensionImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.pension.key.toString(),
              child: 
              !widget.pension.images[selectedImage].contains('add-image.png')
                    ? (Image.file(File(widget.pension.images[selectedImage])))
                    : (Image.asset(widget.pension.images[selectedImage])),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.pension.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: !widget.pension.images[selectedImage].contains('add-image.png')
                    ? (Image.file(File(widget.pension.images[selectedImage])))
                    : (Image.asset(widget.pension.images[selectedImage])),
      ),
    );
  }
}