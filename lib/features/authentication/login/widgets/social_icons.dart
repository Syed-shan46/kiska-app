import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';


class MySocialIcons extends StatelessWidget {
  const MySocialIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/google-icon.png')),
          ),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        // facebook
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/facebook-icon.png')),
          ),
        ),
      ],
    );
  }
}