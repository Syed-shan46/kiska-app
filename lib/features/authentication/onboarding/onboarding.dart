import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/controllers/on_boarding_image_controller.dart';
import 'package:kiska/features/authentication/onboarding/widgets/on_boarding_dot_navigation.dart';
import 'package:kiska/features/authentication/onboarding/widgets/on_boarding_next_button.dart';
import 'package:kiska/utils/constants/image_strings.dart';



import 'widgets/on_boarding_image.dart';
import 'widgets/on_boarding_skip_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [


          /// Onboarding Images
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingImage(image: MyImages.onBoardingImage1,title: 'Choose your Product',
                subtitle:
                    'Cut out the middleman! Get access to exclusive deals and the latest trends from global suppliers.',
              ),

              OnBoardingImage(image: MyImages.onBoardingImage2,title: 'Select Payment Method',
                subtitle:
                'Pay with confidence using our secure payment options. Easy checkout, every time!',
              ),

              OnBoardingImage(image: MyImages.onBoardingImage3,title: 'Start Now',
                subtitle:
                'Start shopping now and enjoy international products at your fingertips. Sign up today!',
              ),
            ],
          ),

          /// Skip Button
          const SkipButton(),

          /// Dot Navigation
          const OnBoardingNavigation(),

          /// Next Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

