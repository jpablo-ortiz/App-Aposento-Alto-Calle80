import 'package:app_aposento_alto_calle80/blocs/login_bloc/login_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/button_options_login.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/input_field_redondo.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error = "";
  bool loading = false;

  late final LoginBloc _loginBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        // three cases:
        if (state.isSubmitting) {
          Get.snackbar(
            "login_in".tr,
            '',
            icon: Icon(Icons.info),
            backgroundColor: Get.theme.colorScheme.secondaryVariant,
          );
        }
        if (state.isFailure) {
          Get.snackbar(
            "login_failure".tr,
            '',
            icon: Icon(
              Icons.error,
              color: Get.theme.backgroundColor,
            ),
            backgroundColor: Colors.red,
            colorText: Get.theme.backgroundColor,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(paddingLarge),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(height: Get.size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: Get.size.height * 0.35,
                ),
                SizedBox(height: Get.size.height * 0.03),
                // Email
                InputFieldRedondo(
                  controller: _emailController,
                  validator: (_) => !state.isEmailValid ? "invalid_email".tr : null,
                  icon: Icons.person,
                  hintText: "email".tr,
                ),
                // Password
                InputFieldRedondo(
                  controller: _passwordController,
                  validator: (_) => !state.isPasswordValid ? "invalid_password".tr : null,
                  icon: Icons.lock,
                  hintText: "password".tr,
                  obscureText: true,
                ),
                // Buttons Options
                ButtonOptionsLogin(
                  onLoginButtonPressed: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() async {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
    await Future.delayed(Duration(seconds: 10));
  }
}
