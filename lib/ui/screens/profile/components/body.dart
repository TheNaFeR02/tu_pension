import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_pension/ui/controllers/authentication_controller.dart';
import 'package:tu_pension/ui/pages/authentication/login.dart';
import 'package:tu_pension/ui/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  AuthenticationController authenticationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mi cuenta",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notificaciones",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Configuraciones",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Ayuda",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Cerrar sesión",
            icon: "assets/icons/Log out.svg",
            press: () {
              authenticationController.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
