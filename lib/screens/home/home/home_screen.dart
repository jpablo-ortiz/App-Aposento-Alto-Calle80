import 'package:app_aposento_alto_calle80/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/screens/home/global/navegation_bar/bottom_nav_bar.dart';
import 'package:app_aposento_alto_calle80/screens/home/global/navegation_bar/principal_button_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    AuthenticationState state = authenticationBloc.state;
    UserApp? userLogged = state is Authenticated ? state.user : null;

    return Scaffold(
      appBar: null,
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PrincipalButtonNavBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              //Text("Nombres: " + (userLogged!.name ?? "")),
              //Text("Apellidos: " + (userLogged.apellidos ?? "")),
              Text("Username: ${userLogged!.username ?? ""}"),
              Text("Email: ${userLogged.email!}"),
              Text("Id: ${userLogged.id!}"),
            ],
          ),
        ),
      ),
    );
  }
}
