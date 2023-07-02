import 'package:app_aposento_alto_calle80/blocs/login_bloc/login_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/login_form.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:app_aposento_alto_calle80/shared/widgets/pantalla_fix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: PantallaFix(
          background: fondoGradient,
          child: const LoginForm(),
        ),
      ),
    );
  }
}
