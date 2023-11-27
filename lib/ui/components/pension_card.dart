import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/screens/details/details_screen.dart';
import 'package:tu_pension/ui/screens/pension_details/details_screen.dart';

class PensionCard extends StatelessWidget {
  const PensionCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.pension,
  }) : super(key: key);

  final double width, aspectRetio;
  final Pension pension;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          // onTap: () => {},
          onTap: () => Navigator.pushNamed(
            context,
            PensionDetailsScreen.routeName,
            arguments: PensionDetailsArguments(pension: pension),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: pension.key.toString(),
                    child: !pension.images[0].contains('add-image.png')
                        ? (Image.file(File(pension.images[0])))
                        : (Image.asset(pension.images[0])),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                pension.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${pension.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: pension.isFavourite ?? false
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: pension.isFavourite ?? false
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
