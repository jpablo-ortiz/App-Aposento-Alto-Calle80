import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';

// Pallete colors
// https://colorswall.com/palette/52989/

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimaryColor,
      textStyle: const TextStyle(color: kPrimaryColor),
    ),
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: kPrimaryColor,
        primaryContainer: kLightColor1,
        secondary: kSecondaryColor,
        secondaryContainer: kLightColor2,
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
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimaryColor,
      textStyle: const TextStyle(color: kPrimaryColor),
    ),
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: kPrimaryColor,
        primaryContainer: kDarkColor1,
        secondary: kSecondaryColor,
        secondaryContainer: kDarkColor2,
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
