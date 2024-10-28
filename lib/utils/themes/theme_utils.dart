import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class ThemeUtils {
  static Color dynamicTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.darkBackground;
  }

  static Color sameBrightness(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(71, 0, 0, 0)
        : Colors.white;
  }
}

class DynamicBg {
  static Color sameBrightness(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBackground
        : Colors.white;
  }
}

class Navbg {
  static Color navbarBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBackground
        : Colors.white;
  }
}
