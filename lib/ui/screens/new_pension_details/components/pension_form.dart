import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/default_button.dart';
import 'package:tu_pension/ui/components/form_error.dart';
import 'package:tu_pension/ui/controllers/authentication_controller.dart';
import 'package:tu_pension/ui/controllers/user_controller.dart';
import 'package:tu_pension/ui/controllers/user_pension_list_controller.dart';
import 'package:tu_pension/ui/screens/home/home_screen.dart';
import 'package:tu_pension/ui/screens/new_pension_details/components/top_rounded_container.dart';
import 'package:tu_pension/ui/screens/user_pension_list/user_pension_list_screen.dart';

class PensionForm extends StatefulWidget {
  const PensionForm({
    Key? key,
    required this.pension,
    required this.images,
  }) : super(key: key);

  final Pension pension;
  final List<String> images;

  @override
  State<PensionForm> createState() => _PensionFormState();
}

class _PensionFormState extends State<PensionForm> {
  UserPensionListController userPensions = Get.find();
  AuthenticationController authController = Get.find();

  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  int? price;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    print('widget.images: ${widget.images}');
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(0)),
              child: buildTitleFormField()),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              width: getProportionateScreenWidth(64),
              decoration: BoxDecoration(
                color: widget.pension.isFavourite ?? false
                    ? Color(0xFFFFE6E6)
                    : Color(0xFFF5F6F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                color: widget.pension.isFavourite ?? false
                    ? Color(0xFFFF4848)
                    : Color(0xFFDBDEE4),
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: buildDescriptionFormField(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: 10,
            ),
            child: const Row(
              children: [],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                bottom: getProportionateScreenWidth(40),
                top: getProportionateScreenWidth(15),
              ),
              child: buildPriceFormField()),
          FormError(errors: errors),
          TopRoundedContainer(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.15,
                right: SizeConfig.screenWidth * 0.15,
                bottom: getProportionateScreenWidth(40),
                top: getProportionateScreenWidth(15),
              ),
              child: DefaultButton(
                text: "Crear Pensión",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Crear Pensión...');
                    print('title: $title');
                    print('description: $description');
                    print('price: $price');
                    print('images: ${widget.images}');
                    try {
                      List<String> images = widget.images
                          .where(
                              (element) => !element.contains('add-image.png'))
                          .toList();
                      await userPensions.createPension(
                        authController.getUid(),
                        authController.userEmail(),
                        title,
                        description,
                        price,
                        images,
                      );
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return UserPensionListScreen();
                          },
                        ));
                      });
                      // redirect to succesfull pension created.
                    } catch (error) {
                      print('Error: $error');
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => title = newValue,
      onChanged: (value) {},
      validator: (value) {},
      decoration: InputDecoration(
        hintText: "Ingresa un título",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => description = newValue,
      onChanged: (value) {},
      validator: (value) {},
      decoration: InputDecoration(
        hintText:
            "Esta es una descripción de ejemplo, la cual deberá ser reemplazada por una descripción real del producto …",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintMaxLines: 7,
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => price = int.parse(newValue ?? '0'),
      onChanged: (value) {},
      validator: (value) {},
      decoration: InputDecoration(
        labelText: "Precio",
        hintText: "ej. \$ 1,249,900.00",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
}
