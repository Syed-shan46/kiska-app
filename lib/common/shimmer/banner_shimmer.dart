import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiska/common/shimmer/shimmer_widget.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Column(
        children: [
          ShimmerWidget(
              shimmerWidth: double.infinity.h,
              shimmerHeight: 140.h,
              shimmerRadius: 12),
        ],
      ),
    );
  }
}
