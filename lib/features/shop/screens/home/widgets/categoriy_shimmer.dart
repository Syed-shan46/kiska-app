import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiska/common/shimmer/shimmer_widget.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ShimmerWidget(
          shimmerWidth: 70.h, shimmerHeight: 70.h, shimmerRadius: 12),
    );
  }
}
