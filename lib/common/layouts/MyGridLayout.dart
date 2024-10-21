import 'package:flutter/material.dart';

class MyGridLayout extends StatelessWidget {
  const MyGridLayout(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent = 200,
      required this.itemBuilder,
      this.crossSpacing = 0,
      this.mainSpacing = 32});

  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double crossSpacing;
  final double mainSpacing;

  @override
  Widget build(BuildContext context) {
    final desiredWidth = mainAxisExtent;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeightRatio = desiredWidth / screenHeight;
    final double setHeight = (screenHeight * itemHeightRatio);

    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: mainSpacing,
        crossAxisSpacing: crossSpacing,
        mainAxisExtent: setHeight,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
