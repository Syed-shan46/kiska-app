// MyBannerWidget
import 'package:flutter/material.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyBannerWidget extends StatefulWidget {
  const MyBannerWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<MyBannerWidget> createState() => _MyBannerWidgetState();
}

class _MyBannerWidgetState extends State<MyBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            widget.imageUrl, // Change to Image.network to load from URL
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width, // Full width
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image loaded successfully
              } else {
                // Show a progress indicator while the image is loading
                return Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                  child:
                      Text('Error loading image')); // Handle image load errors
            },
          ),
        ),
      ),
    );
  }
}
