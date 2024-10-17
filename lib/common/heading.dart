import 'package:flutter/material.dart';

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
          Text(
            headingRight,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
