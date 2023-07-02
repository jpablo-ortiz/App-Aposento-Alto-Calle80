import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';

// Pallete colors
// https://colorswall.com/palette/52989/

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  backgroundColor: kLightColor1,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimaryColor,
      textStyle: const TextStyle(color: kPrimaryColor),
    ),
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: kPrimaryColor,
        primaryVariant: kLightColor1,
        secondary: kSecondaryColor,
        secondaryVariant: kLightColor2,
        background: kLightColor1,
        onError: kSecondaryColor,
      ),
  iconTheme: const IconThemeData(color: kSecondaryColor),
  inputDecorationTheme: const InputDecorationTheme(
    errorStyle: TextStyle(color: kPrimaryColor),
    focusColor: kSecondaryColor,
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  backgroundColor: kDarkColor1,
  scaffoldBackgroundColor: kDarkColor1,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimaryColor,
      textStyle: const TextStyle(color: kPrimaryColor),
    ),
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: kPrimaryColor,
        primaryVariant: kDarkColor1,
        secondary: kSecondaryColor,
        secondaryVariant: kDarkColor2,
        background: kDarkColor1,
        onError: kSecondaryColor,
      ),
  iconTheme: const IconThemeData(color: kSecondaryColor),
  inputDecorationTheme: const InputDecorationTheme(
    errorStyle: TextStyle(color: kPrimaryColor),
    focusColor: kSecondaryColor,
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
  ),
);
