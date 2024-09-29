import 'package:flutter/material.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';


class MyAuthHeader extends StatelessWidget {
  const MyAuthHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyPrimaryHeaderContainer(
      color: AppColors.primaryColor,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
