import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/search/search.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.needBorder});

  final bool needBorder;

  @override
  Widget build(BuildContext context) { final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9, top: 8),
      child: InkWell(
          onTap: () {
            Get.to(() => SearchScreen());
          },
          child: Container(
            
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            decoration: BoxDecoration(
              border: needBorder
                  ? Border.all(
                      color:
                          ThemeUtils.dynamicTextColor(context).withOpacity(0.8))
                  : null,
              color: isDarkMode
                  ? AppColors.darkBackground
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Icon(Iconsax.search_favorite),
                Text(
                  ' What are you looking for?',
                  style: TextStyle(color: ThemeUtils.dynamicTextColor(context)),
                ),
              ],
            ),
          )),
    );
  }
}
