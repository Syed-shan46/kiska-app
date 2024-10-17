import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class ThemeUtils {
  static Color dynamicTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
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
