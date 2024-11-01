import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/banner_controller.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';
import 'package:kiska/features/shop/models/banner_model.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_widget.dart';
import 'package:kiska/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBannerSlider extends StatefulWidget {
  const MyBannerSlider({super.key});

  @override
  State<MyBannerSlider> createState() => _MyBannerSliderState();
}

class _MyBannerSliderState extends State<MyBannerSlider> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return FutureBuilder<List<BannerModel>>(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 200,
            child: Center(
              child: LoadingAnimationWidget.hexagonDots(
                  color: AppColors.primaryColor, size: 20),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No banners available'));
        }

        final banners = snapshot.data!;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 140.h,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
                autoPlay: true,
              ),
              items: banners.map((banner) {
                return MyBannerWidget(imageUrl: banner.image); // Use your widget here
              }).toList(),
            ),
            Positioned(
              bottom: 35,
              child: MyDotNavigation(
                controller: controller,
                dotCount: banners.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
