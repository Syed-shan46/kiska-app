import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';


class MyWelcomeText extends StatelessWidget {
  const MyWelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        const Text(
            'To keep connected with us please login with your personal info'),
      ],
    );
  }
}