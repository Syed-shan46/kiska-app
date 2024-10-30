import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

import 'circular_container.dart';
import 'curved_edges_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPrimaryHeaderContainer extends StatelessWidget {
  const MyPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.showContainer = true,
    required this.color,
  });

  final Widget child;
  final bool showContainer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MyCurvedWidget(
      child: Container(
        
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        decoration: BoxDecoration(color: color),
       
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
