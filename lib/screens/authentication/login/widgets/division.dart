import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Division extends StatelessWidget {
  Division();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.size.height * 0.02),
      width: Get.size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "O",
              style: TextStyle(
                color: KButtonAuthColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
