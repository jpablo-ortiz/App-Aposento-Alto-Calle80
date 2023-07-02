import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';

class YaTengoUnaCuenta extends StatelessWidget {
  final bool login;
  final Function() press;

  const YaTengoUnaCuenta({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          // TODO - Internationalization
          login ? "¿No tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: const TextStyle(color: KButtonAuthColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            // TODO - Internationalization
            login ? " Regístrate" : " Inicia sesión",
            style: const TextStyle(
              color: KButtonAuthColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
