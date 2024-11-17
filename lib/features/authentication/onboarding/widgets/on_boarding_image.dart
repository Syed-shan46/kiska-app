import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/device/device_utility.dart';

class OnBoardingImage extends StatelessWidget {
  const OnBoardingImage({
    super.key,
    required this.image,
    required this.subtitle,
    required this.title,
  });

  final String image, subtitle, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            width: MyDeviceUtils.getScreenWidth(context) * 0.8,
            height: MyDeviceUtils.getScreenHeight() * 0.6,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: MySizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
