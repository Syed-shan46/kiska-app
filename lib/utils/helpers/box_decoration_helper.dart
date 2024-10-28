// box_decoration_helper.dart
import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

/// Returns a BoxDecoration based on the brightness of the theme.
BoxDecoration getDynamicBoxDecoration(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return BoxDecoration(
    color: DynamicBg.sameBrightness(context), // Base color for the box
    boxShadow: isDarkMode
        ? [] // No shadow in dark mode
        : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color for light mode
              blurRadius: 50,
              offset: Offset(0, 10),
            ),
          ],
    border: isDarkMode
        ? Border.all(color: Colors.white.withOpacity(0.7), width: 2) // Border for dark mode
        : null, // No border in light mode
    borderRadius: BorderRadius.circular(12), // Optional rounded corners
  );
}
