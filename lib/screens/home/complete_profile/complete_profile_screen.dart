import 'package:app_aposento_alto_calle80/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/home/complete_profile/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: BlocProvider.value(
        value: _authBloc,
        child: CompleteProfileForm(),
      ),
    );
  }
}
