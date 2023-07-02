import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      constraints: const BoxConstraints.tightFor(height: 70.0),
      child: Material(
        borderRadius: BorderRadius.circular(35),
        color: Colors.white,
        elevation: 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.black54,
                size: 30.0,
              ),
              onPressed: () => Get.toNamed('/members_list'),
            ),
            IconButton(
              icon: const Icon(
                Icons.email,
                color: Colors.black54,
                size: 30.0,
              ),
              onPressed: () => Get.toNamed('/complete_profile_screen'),
            ),
            const SizedBox(width: 10.0),
            IconButton(
              icon: const Icon(
                Icons.email,
                color: Colors.black54,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.black54,
                size: 30.0,
              ),
              onPressed: () async => getIt.get<AuthenticationRepository>().logOut(),
            ),
          ],
        ),
      ),
    );
  }
}
