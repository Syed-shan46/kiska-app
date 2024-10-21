import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/text_theme.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColor,
    secondary: AppColors.accentColor,
    error: AppColors.errorColor,
    surface: AppColors.darkBackground,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onError: Colors.white,
    onSurface: AppColors.darkTextColor,
  ),
  appBarTheme:  const AppBarTheme(
    color: AppColors.darkBackground,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: textTheme.apply(bodyColor: AppColors.darkTextColor),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 44, 43, 43),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkBackground,
    // Use primary color for dark theme
    selectedItemColor: AppColors.primaryColor, // Selected item color
    unselectedItemColor: Colors.grey, // Unselected item color
  ),

  elevatedButtonTheme: ElevatedButtonThemeData( 
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.lightBackground.withOpacity(0.8)))
  )
);
