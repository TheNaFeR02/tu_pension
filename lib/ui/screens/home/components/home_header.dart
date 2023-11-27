import 'package:flutter/material.dart';

import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/screens/cart/cart_screen.dart';
import 'package:tu_pension/ui/screens/new_pension_details/details_screen.dart';
import 'package:tu_pension/ui/screens/user_pension_list/user_pension_list_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/add.svg",
            press: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserPensionListScreen(),
              ),
            ),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
