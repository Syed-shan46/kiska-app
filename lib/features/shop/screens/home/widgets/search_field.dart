import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/store/store.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9, top: 8),
      child: GestureDetector(
        onTap: () => Get.to(() => const StoreScreen(
           
            )),
        child: TextField(
          decoration: InputDecoration(
            fillColor: isDarkMode
                ? AppColors.darkBackground
                : Colors.white.withOpacity(0.9),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: 'What are you looking for?',
            hintStyle: TextStyle(
                color: ThemeUtils.dynamicTextColor(context).withOpacity(0.8)),
            prefixIcon: Icon(
              Iconsax.search_normal,
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }
}
