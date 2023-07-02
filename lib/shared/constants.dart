import 'package:flutter/material.dart';

//-------------------------------------------------
//------------------- STRINGS ---------------------
//-------------------------------------------------

const APP_NAME = 'Aposento Alto Calle 80';

//-------------------------------------------------
//--------------- SIZE CONSTANTS ------------------
//-------------------------------------------------

const paddingSmall = 8.0;
const paddingMedium = 16.0;
const paddingLarge = 24.0;
const paddingXLarge = 32.0;
const paddingXXLarge = 40.0;

const textSizeSmall = 12.0;
const textSizeSmall2 = 14.0;
const textSizeMedium = 16.0;
const textSizeLarge = 20.0;
const textSizeXLarge = 24.0;

const circleRaidusSmall = 24.0;
const circleRaidusMedium = 32.0;
const circleRaidusLarge = 48.0;
const circleRaidusXLarge = 64.0;

//---------------------------------------------------
//------------------ DURATIONS ----------------------
//---------------------------------------------------

const loginDuration = Duration(seconds: 2);
const signUpDuration = Duration(seconds: 2);
const splashScreenDuration = Duration(seconds: 2);
const errorFormFieldVerificationDuration = Duration(milliseconds: 100);

//---------------------------------------------------
//--------------- COLORS CONSTANTS ------------------
//---------------------------------------------------

// Base colors
const Color kPrimaryColor = Colors.indigo;
const Color kSecondaryColor = Color(0xFF283593);
const Color kTertiaryColor = Color(0xFF7986CB);

// Light and dark colors (Usually on the backgrounds)
const Color kLightColor1 = Colors.white;
const Color kLightColor2 = Color.fromRGBO(245, 245, 245, 1);

const Color kDarkColor1 = Color.fromRGBO(36, 46, 62, 1);
const Color kDarkColor2 = Color.fromRGBO(61, 68, 82, 1);

// Specific colors
// TODO - cambiar esto o por un color llamado color para boton authenticacion o mirar otra forma
const Color KButtonAuthColor = Color(0xFFb71c1c);

// For gradient
final Color colorGradient1 = Colors.indigo[600]!;
final Color colorGradient2 = Colors.indigo[700]!;
final Color colorGradient3 = Colors.indigo[800]!;
final Color colorGradient4 = Colors.indigo[900]!;

final fondoGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        colorGradient1,
        colorGradient2,
        colorGradient3,
        colorGradient4,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ),
);

final kScaffoldBackgroundGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0.1, 0.5, 0.8],
  colors: [
    Colors.blue[600]!,
    Colors.blue[500]!,
    Colors.blue[400]!,
  ],
);
