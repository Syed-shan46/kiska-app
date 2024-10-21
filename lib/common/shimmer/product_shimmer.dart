import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiska/common/shimmer/shimmer_widget.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: Column(
        children: [
          ShimmerWidget(
              shimmerWidth:double.infinity.h, shimmerHeight: 90.h, shimmerRadius: 10),
        ],
      ),
    );
  }
}