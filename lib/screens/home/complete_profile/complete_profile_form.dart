import 'package:app_aposento_alto_calle80/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNamesController = TextEditingController();

  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(paddingLarge),
          child: ListView(
            children: <Widget>[
              SizedBox(height: Get.size.height * 0.03),
              // names
              TextFormField(
                controller: _namesController,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "names".tr,
                ),
              ),
              SizedBox(height: Get.size.height * 0.03),
              // last names
              TextFormField(
                controller: _lastNamesController,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "last_names".tr,
                ),
              ),
              SizedBox(height: Get.size.height * 0.03),
              ElevatedButton(
                onPressed: () async {
                  if (state is FirstTime) {
                    UserApp user = state.user;
                    user = user.copyWith(
                      names: _namesController.text,
                      lastNames: _lastNamesController.text,
                    );
                    await getIt.get<AuthenticationRepository>().createUpdateAllUserInfo(user);
                    return _authenticationBloc.add(AuthenticationUserChanged(user));
                  }
                },
                child: Text("save".tr),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _namesController.dispose();
    _lastNamesController.dispose();
    super.dispose();
  }
}
