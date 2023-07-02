import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
  );
  SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: paddingLarge, vertical: paddingMedium),
        hintText: "search".tr,
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
