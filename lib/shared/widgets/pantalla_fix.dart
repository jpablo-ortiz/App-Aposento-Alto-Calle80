import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantallaFix extends StatelessWidget {
  final Widget child;
  final Widget background;

  const PantallaFix({
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          background,
          child,
        ],
      ),
    );
  }
}
