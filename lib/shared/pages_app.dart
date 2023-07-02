import 'package:app_aposento_alto_calle80/screens/authentication/login/login_screen.dart';
import 'package:app_aposento_alto_calle80/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:app_aposento_alto_calle80/screens/home/complete_profile/complete_profile_screen.dart';
import 'package:app_aposento_alto_calle80/screens/home/home/home_screen.dart';
import 'package:app_aposento_alto_calle80/screens/home/members_list/members_list_screen.dart';
import 'package:app_aposento_alto_calle80/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

// Transition constant
Transition defaultTransition = Transition.cupertino;

// Routes pages
List<GetPage<dynamic>> routesPages = [
  GetPage(
    name: '/splash',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: '/sign_up',
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
  ),
  //GetPage(
  //  name: '/settings',
  //  page: () => SettingsScreen(),
  //  transition: defaultTransition,
  //),
  GetPage(
    name: '/members_list',
    page: () => const MembersListScreen(),
  ),
  GetPage(
    name: '/complete_profile_screen',
    page: () => const CompleteProfileScreen(),
  ),
];
