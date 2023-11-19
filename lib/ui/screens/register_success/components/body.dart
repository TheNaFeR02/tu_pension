import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/default_button.dart';
import 'package:tu_pension/ui/screens/error/error_screen.dart';
import 'package:tu_pension/ui/screens/home/home_screen.dart';
import 'package:tu_pension/ui/screens/sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Register Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to Login",
            press: () {
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null) {
                  print('If firebase wasnt able to logged automatically after logged in.');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                } else {
                  print('Automatically redirected to home screen after account creation.');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                }
              });
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
