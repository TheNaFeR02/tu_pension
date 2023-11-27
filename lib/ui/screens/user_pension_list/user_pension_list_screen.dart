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
  RxList<Pension> pensions = <Pension>[].obs;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    pensionListController.startPensions();

    // Directly assign pensions to pensionListController.userPensions
    pensions = pensionListController.userPensions;

    // No need for addPostFrameCallback here

    // your obx var, eg. global_variables.appBarTitle.value = "Messages";

    // your obx var, eg. global_variables.appBarTitle.value = "Messages";
  }

  @override
  void dispose() {
    // Stop listening to changes.
    pensionListController.stopPensions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   pensions = pensionListController.userPensions;
    // });
    // print(pensions);
    pensions = pensionListController.userPensions;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Pensiones'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Obx will automatically rebuild when pensions changes
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: pensions.length,
          itemBuilder: (context, index) {
            var pension = pensions[index];

            // Replace 'YourProductCardWidget' with the actual widget
            return Container(
              child: PensionCard(
                pension: pension as Pension,
                // Add other properties as needed
              ),
              padding: EdgeInsets.all(16),
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(15),
            horizontal: getProportionateScreenWidth(20)),
        child: DefaultButton(
          text: "Crear Pensión",
          press: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePensionDetailScreen(),
              )
            );
          },
        ),
      ),
    );
  }
}
