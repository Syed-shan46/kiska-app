import 'package:flutter/material.dart';
import 'package:kiska/features/authentication/controllers/on_boarding_image_controller.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/device/device_utility.dart';



class OnBoardingPrevButton extends StatelessWidget {
  const OnBoardingPrevButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MyDeviceUtils.getBottomNavigationBarHeight() + 10,
        left: MySizes.defaultSpace,
        child: SizedBox(
          height:50,
          child: OutlinedButton(
            onPressed: () => OnBoardingController.instance.prevPage(),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.teal),
              shape: const CircleBorder(),

            ),
            child:  Icon(Icons.arrow_back_ios,size: 19,
                color: Theme.of(context).colorScheme.primaryFixed,),
          ),
        ));
  }
}
