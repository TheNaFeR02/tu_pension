import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_pension/data/model/Product.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/pension_card.dart';
import 'package:tu_pension/ui/components/product_card.dart';
import 'package:tu_pension/ui/controllers/user_pension_list_controller.dart';

import 'section_title.dart';

// class RandomPensions extends StatelessWidget {
//   static String routeName = "/random_pensions";

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<UserPensionListController>(
//       init: UserPensionListController(), // Initialize your controller here
//       builder: (controller) {
//         // You can access controller methods and properties here
//         controller.startPensions();

//         return Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: getProportionateScreenWidth(20)),
//               child:
//                   SectionTitle(title: "Te podrían interesar...", press: () {}),
//             ),
//             SizedBox(height: getProportionateScreenWidth(20)),
//             Obx(
//               () => SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     ...List.generate(
//                       controller.userPensions.length,
//                       (index) {
//                         return PensionCard(
//                           pension: controller.userPensions[index],
//                         );
//                       },
//                     ),
//                     SizedBox(width: getProportionateScreenWidth(20)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class RandomPensions extends StatelessWidget {
  static String routeName = "/random_pensions";

  UserPensionListController pensionListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPensionListController>(
      init: UserPensionListController(), // Initialize your controller here
      builder: (controller) {
        // You can access controller methods and properties here
        controller.startPensions();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child:
                  SectionTitle(title: "Te podrían interesar...", press: () {}),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var pension in controller.userPensions)
                      PensionCard(
                        pension: pension,
                      ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
