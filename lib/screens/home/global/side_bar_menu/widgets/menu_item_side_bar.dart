import 'package:flutter/material.dart';

class MenuItemSideBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final String? subtitle;
  final void Function()? onClicked;

  const MenuItemSideBar({
    Key? key,
    required this.text,
    required this.icon,
    this.subtitle,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: TextStyle(color: color)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
