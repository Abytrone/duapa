import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    primaryColorDark: const Color(0xFF505050),
    brightness: Brightness.light,
    dividerTheme: const DividerThemeData(
      color: Color(0xFFD9D9D9),
    ),
    // scaffoldBackgroundColor: kLightBackgroundColor,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      // backgroundColor: Colors.transparent,
      // foregroundColor: kDarkColor,
    ),
    iconTheme: const IconThemeData(color: kDarkColor),
    textTheme: Theme.of(context).textTheme.apply(
          displayColor: kDarkColor,
          fontFamily: 'Gotik',
        ),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: kDarkColor,
        fontFamily: 'Gotik',
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      unselectedItemColor: kLightGreyColor,
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      unselectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: kContentColorDarkTheme),
    textTheme: Theme.of(context).textTheme.apply(
          // bodyColor: kContentColorDarkTheme,
          displayColor: kContentColorDarkTheme,
          fontFamily: 'Gotik',
        ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor,
        )
        .copyWith(surface: kContentColorDarkTheme),
  );
}

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
);
