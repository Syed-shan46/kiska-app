import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class MyHeading extends StatelessWidget {
  const MyHeading({
    super.key,
    required this.headingLeft,
    required this.headingRight,
  });

  final String headingLeft;
  final String headingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingLeft,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/more-7.svg',
                height: 23,
                color: AppColors.primaryColor,
              )),
        ],
      ),
    );
  }
}
