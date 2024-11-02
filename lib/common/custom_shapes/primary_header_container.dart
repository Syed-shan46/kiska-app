import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

import 'circular_container.dart';
import 'curved_edges_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPrimaryHeaderContainer extends StatelessWidget {
  const MyPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.showContainer = true,
    this.height = 230,
    required this.color,
  });

  final Widget child;
  final bool showContainer;
  final Color color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MyCurvedWidget(
      child: Container(
        
        width: MediaQuery.of(context).size.width,
        height: height!.h,
        decoration: BoxDecoration(color: isDarkMode? Colors.grey.withOpacity(0.1): AppColors.primaryColor),
       
        child: Stack(
          children: [
            showContainer
                ? Positioned(
                    top: -70,
                    right: -70,
                    child: MyCircularContainer(
                      width: 205,
                      height: 205,
                      radius: 400,
                      backgroundColor:
                          DynamicBg.sameBrightness(context).withOpacity(0.1),
                    ),
                  )
                : const SizedBox(
                    height: null,
                  ),
            showContainer
                ? Positioned(
                    top: -70,
                    right: -25,
                    child: MyCircularContainer(
                        width: 205,
                        height: 205,
                        radius: 400,
                        backgroundColor:
                            DynamicBg.sameBrightness(context).withOpacity(0.1)),
                  )
                : const SizedBox(
                    height: null,
                  ),
            child,
          ],
        ),
      ),
    );
  }
}
