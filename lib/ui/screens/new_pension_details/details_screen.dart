import 'package:flutter/material.dart';
import 'package:tu_pension/data/model/Pension.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class CreatePensionDetailScreen extends StatelessWidget {
  static String routeName = "/create_pension_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 0.0),
      ),
      body: Body(),
    );
  }
}

class CreatePensionDetailsArguments {
  final Pension pension;

  CreatePensionDetailsArguments({required this.pension});
}
