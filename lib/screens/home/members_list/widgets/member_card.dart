import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final UserApp user;

  const MemberCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          //title: Text(user.nombres + " " + user.apellidos),
          title: Text(user.names ?? user.username ?? ""),
          subtitle: Text(user.email!),
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: kPrimaryColor, //ColorPrimarioClaro,
          ),
        ),
      ),
    );
  }
}
