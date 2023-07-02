import 'package:flutter/foundation.dart';

import 'package:app_aposento_alto_calle80/blocs/login_bloc/login_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/division.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/social_icon.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/ya_tengo_una_cuenta.dart';
import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/preferences_repository.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ButtonOptionsLogin extends StatelessWidget {
  const ButtonOptionsLogin({
    Key? key,
    required this.onLoginButtonPressed,
  }) : super(key: key);

  final VoidCallback? onLoginButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _childrensToShow(context),
    );
  }

  List<Widget> _childrensToShow(context) {
    List<Widget> childrens = [
      // Button Login
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: Get.size.width * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: ElevatedButton(
            onPressed: onLoginButtonPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(KButtonAuthColor),
            ),
            child: const Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      SizedBox(height: Get.size.height * 0.01),
      // YaTengoUnaCuenta
      YaTengoUnaCuenta(
        press: () => Get.toNamed('/sign_up'),
        login: true,
      ),
    ];

    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
      childrens.add(const Division());
      childrens.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSrc: "assets/icons/facebook.svg",
              press: () {
                getIt.get<PreferencesRepository>().saveLocale(const Locale("en", "US"));
              },
            ),
            SocalIcon(
              iconSrc: "assets/icons/twitter.svg",
              press: () {
                getIt.get<PreferencesRepository>().saveLocale(const Locale("es", "ES"));
              },
            ),
            SocalIcon(
              iconSrc: "assets/icons/google-plus.svg",
              press: () {
                Get.snackbar(
                  "login_in".tr,
                  "login_in_with_google".tr,
                  icon: const Icon(Icons.info),
                  backgroundColor: Get.theme.colorScheme.secondaryContainer,
                );
                BlocProvider.of<LoginBloc>(context).add(
                  LoginWithGooglePressed(),
                );
              },
            ),
          ],
        ),
      );
    }

    return childrens;
  }
}
