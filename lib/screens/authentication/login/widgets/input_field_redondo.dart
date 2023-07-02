import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputFieldRedondo extends StatelessWidget {
  const InputFieldRedondo({
    Key? key,
    required this.controller,
    required this.validator,
    required this.icon,
    required this.hintText,
    this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData icon;
  final String hintText;
  final String? labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: Get.size.width * 0.8,
      decoration: BoxDecoration(
        color: kLightColor1,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        obscureText: obscureText,
        cursorColor: KButtonAuthColor,
        style: TextStyle(color: KButtonAuthColor),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: KButtonAuthColor,
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black26),
          errorStyle: TextStyle(color: KButtonAuthColor),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: KButtonAuthColor)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
