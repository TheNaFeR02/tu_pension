import 'package:flutter/material.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/data/model/Product.dart';
import 'package:tu_pension/ui/screens/details/components/custom_app_bar.dart';
import 'components/body.dart';

class PensionDetailsScreen extends StatelessWidget {
  static String routeName = "/pension_details";

  @override
  Widget build(BuildContext context) {
    final PensionDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as PensionDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: double.parse(agrs.pension.rating)),
      ),
      body: Body(pension: agrs.pension),
    );
  }
}

class PensionDetailsArguments {
  final Pension pension;

  PensionDetailsArguments({required this.pension});
}
