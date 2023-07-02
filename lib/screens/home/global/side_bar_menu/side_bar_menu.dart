import 'package:app_aposento_alto_calle80/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/screens/home/global/side_bar_menu/widgets/header_side_bar.dart';
import 'package:app_aposento_alto_calle80/screens/home/global/side_bar_menu/widgets/menu_item_side_bar.dart';
import 'package:app_aposento_alto_calle80/screens/home/global/side_bar_menu/widgets/search_field.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class SideBarMenu extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;
  late final String name;
  late final String email;
  late final String urlImage;

  SideBarMenu({
    Key? key,
    required this.authenticationBloc,
  }) : super(key: key) {
    AuthenticationState state = authenticationBloc.state;
    if (state is Authenticated) {
      UserApp user = state.user;
      this.name = user.names ?? user.username ?? "EXAMPLE NAME"; //"Vera Pagac";
      this.email = user.email!; //"ortizrubio09@gmail.com";
      this.urlImage = user.photoUrl ?? "https://images.unsplash.com/photo-1518991669955-9c7e78ec80ca?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: context.theme.primaryColor,
        child: SafeArea(
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                HeaderSideBar(
                  urlImage: urlImage,
                  name: name,
                  email: email,
                  onClick: () => Get.toNamed(
                    '/profile',
                    arguments: {'name': name, 'urlImage': urlImage},
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingLarge),
                  child: Column(
                    children: <Widget>[
                      SearchField(),
                      SizedBox(height: paddingLarge),
                      MenuItemSideBar(
                        text: "people".tr,
                        icon: Icons.people,
                        onClicked: () => openScreen(name: '/home'),
                      ),
                      SizedBox(height: paddingMedium),
                      MenuItemSideBar(
                        text: "notifications".tr,
                        icon: Icons.notifications_outlined,
                      ),
                      SizedBox(height: paddingMedium),
                      MenuItemSideBar(
                        text: "settings".tr,
                        icon: Icons.settings_outlined,
                        onClicked: () => openScreen(name: '/settings'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openScreen({required String name}) {
    Get.back();
    if (Get.currentRoute != name) Get.toNamed(name);
  }
}
