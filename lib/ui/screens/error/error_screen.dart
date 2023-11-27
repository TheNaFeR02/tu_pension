
import 'package:flutter/material.dart';

import 'components/body.dart';

class ErrorScreen extends StatelessWidget {
  static String routeName = "/error";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Error!!"),
      ),
      body: Body(),
    );
  }
}

