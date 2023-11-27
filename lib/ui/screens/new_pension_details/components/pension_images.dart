import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';

class PensionImages extends StatefulWidget {
  const PensionImages(
      {Key? key, required this.pension, required this.updatePreviewImages})
      : super(key: key);

  final Pension pension;
  final Function(List<String>) updatePreviewImages;

  @override
  _PensionImagesState createState() => _PensionImagesState();
}

class _PensionImagesState extends State<PensionImages> {
  int selectedImage = 0;
  List<String> myFile = [];
  ImagePicker? picker = ImagePicker();
  List<String> previewImages = [];

  @override
  void initState() {
    super.initState();
    previewImages = List.of(widget.pension.images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            var file = await picker?.pickImage(source: ImageSource.gallery);
            if (file != null && File(file.path).existsSync()) {
              setState(() {
                previewImages[selectedImage] = file.path;
                widget.updatePreviewImages(previewImages);
              });
            }
          },
          child: SizedBox(
            width: getProportionateScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: widget.pension.id.toString(),
                child: !previewImages[selectedImage].contains('add-image.png')
                    ? (Image.file(File(previewImages[selectedImage])))
                    : (Image.asset(previewImages[selectedImage])),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(previewImages.length,
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
        child: !previewImages[index].contains('add-image.png')
            ? (Image.file(File(previewImages[index])))
            : (Image.asset(previewImages[index])),
      ),
    );
  }
}
