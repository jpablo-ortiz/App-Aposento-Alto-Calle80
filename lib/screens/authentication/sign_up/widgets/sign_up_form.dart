import 'package:app_aposento_alto_calle80/blocs/signup_bloc/signup_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/login/widgets/input_field_redondo.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignupBloc _signupBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignupState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        // if state is submitting
        if (state.isSubmitting) {
          Get.snackbar(
            '${"registering".tr}...',
            '',
            icon: const Icon(Icons.info),
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
          );
        }
        // if state is failure
        if (state.isFailure) {
          Get.snackbar(
            "register_failure".tr,
            '',
            icon: Icon(
              Icons.error,
              color: Get.theme.colorScheme.background,
            ),
            backgroundColor: Colors.red,
            colorText: Get.theme.colorScheme.background,
          );
        }
        // if state is success
        if (state.isSuccess) {
          Get.back();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(paddingLarge),
          child: Form(
            child: ListView(
              children: <Widget>[
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

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Sign up button
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: Get.size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ElevatedButton(
                            onPressed: isSignUpButtonEnabled(state) ? _onFormSubmitted : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KButtonAuthColor),
                            ),
                            child: Text(
                              "sign_up".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  _onEmailChanged() {
    _signupBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  _onPasswordChanged() {
    _signupBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  _onFormSubmitted() {
    _signupBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
