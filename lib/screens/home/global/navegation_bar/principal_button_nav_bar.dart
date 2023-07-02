import 'package:flutter/material.dart';

class PrincipalButtonNavBar extends StatelessWidget {
  const PrincipalButtonNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.grey.shade300,
      onPressed: () => Navigator.pushReplacementNamed(context, '/Principal'),
      tooltip: 'Increment',
      child: Icon(
        Icons.home,
        color: Colors.black54,
      ),
    );
  }
}
