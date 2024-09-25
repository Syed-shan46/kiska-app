import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_widget.dart';
import 'package:kiska/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:kiska/utils/constants/image_strings.dart';

class MyBannerSlider extends StatelessWidget {
  const MyBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Carousal Indicator
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: const [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 13),
              child: MyBannerWidget(imageUrl: MyImages.promoBanner1),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 13),
              child: MyBannerWidget(imageUrl: MyImages.promoBanner2),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 13),
              child: MyBannerWidget(imageUrl: MyImages.promoBanner3),
            ),
          ],
        ),
        Positioned(
          bottom: 27,
          child: MyDotNavigation(controller: controller),
        )
      ],
    );
  }
}
