import 'package:app_aposento_alto_calle80/blocs/signup_bloc/signup_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/sign_up/widgets/sign_up_form.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:app_aposento_alto_calle80/shared/widgets/pantalla_fix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: PantallaFix(
          background: fondoGradient,
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
