import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/default_button.dart';
import 'package:tu_pension/ui/components/pension_card.dart';
import 'package:tu_pension/ui/controllers/user_pension_list_controller.dart';
import 'package:tu_pension/ui/screens/details/components/top_rounded_container.dart';
import 'package:tu_pension/ui/screens/new_pension_details/details_screen.dart';

class UserPensionListScreen extends StatefulWidget {
  static String routeName = "/user_pension_list";

  @override
  State<UserPensionListScreen> createState() => _UserPensionListScreenState();
}

class _UserPensionListScreenState extends State<UserPensionListScreen> {
  UserPensionListController pensionListController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pensionListController.startPensions();
    });
  }

  @override
  void dispose() {
    pensionListController.stopPensions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPensionListController>(
      init: UserPensionListController(),
      builder: (controller) {
        // controller.startPensions();

        return Scaffold(
          appBar: AppBar(title: Text('Create Pension')),
          body: Obx(() => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.userPensions.length,
                  itemBuilder: (context, index) {
                    var pension = controller.userPensions[index];

                    // Replace 'YourProductCardWidget' with the actual widget
                    return Container(
                      child: PensionCard(
                        pension: pension as Pension,
                        // Add other properties as needed
                      ),
                      padding: EdgeInsets.all(16),
                    );
                  })

              // () => SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   physics: BouncingScrollPhysics(),
              //   child: Column(
              //     children: [
              //       for (var pension in controller.userPensions)
              //         PensionCard(
              //           pension: pension,
              //         ),
              //       SizedBox(width: getProportionateScreenWidth(20)),
              //     ],
              //   ),
              // ),
              ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(15),
              horizontal: getProportionateScreenWidth(20),
            ),
            child: DefaultButton(
              text: "Crear Pensión",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePensionDetailScreen(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
