import 'package:flutter/material.dart';
import 'package:tu_pension/enums.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/coustom_bottom_nav_bar.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
