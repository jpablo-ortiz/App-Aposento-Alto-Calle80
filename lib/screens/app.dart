import 'package:app_aposento_alto_calle80/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:app_aposento_alto_calle80/l10n/strings.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:app_aposento_alto_calle80/shared/pages_app.dart';
import 'package:app_aposento_alto_calle80/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  final Locale? locale;

  const App({
    Key? key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>.value(
      value: BlocProvider.of<AuthenticationBloc>(context),
      child: GetMaterialApp(
        //App
        title: APP_NAME,

        // GetX
        initialRoute: '/splash',
        getPages: routesPages,
        defaultTransition: defaultTransition,

        // Themes
        theme: lightTheme,
        //darkTheme: darkTheme,
        //themeMode: ThemeMode.system,

        //Internationalization

        // To get device locale Get.deviceLocale.
        // Aparently the GetMaterialApp doesn't support the update of the language
        // (Only on the first build)
        // So we use the Get.updateLocale(locale; in PreferenceRepository to change the language
        locale: locale ?? Locale('es', 'ES'),
        fallbackLocale: Locale('es', 'ES'),
        translations: Strings(),
      ),
    );
  }
}
