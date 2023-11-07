import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_pension/ui/controllers/authentication_controller.dart';
import 'package:tu_pension/ui/controllers/user_controller.dart';
import 'package:tu_pension/ui/pages/authentication/login.dart';

class Central extends StatelessWidget {
  const Central({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthenticationController());
    Get.put(UserController());
    
    return  Scaffold(
      body: LoginPage(),
    );
  }
}
