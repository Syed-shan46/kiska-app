import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class MySectionHeading extends StatelessWidget {
  const MySectionHeading({
    super.key,
    this.textColor,
    this.showActionbutton = true,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionbutton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        if (showActionbutton)
          TextButton(
            onPressed: () {},
            child: Text(
              buttonTitle,
              style:  TextStyle(color: AppColors.primaryColor.withOpacity(0.8)),
            ),
          )
      ],
    );
  }
}
