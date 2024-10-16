import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.price,
      required this.onTap,
      required this.category});

  final String imageUrl;
  final String productName;
  final String category;
  final int price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Card(
          elevation: 4,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Image loaded successfully
                  } else {
                    // Show a progress indicator while the image is loading
                    return SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      ),
                    );
                  }
                },
                imageUrl,
                fit: BoxFit.contain,
                height: 120,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons
                      .error); // Optionally, show an error icon if the image fails to load
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Row(
                        children: [
                          Text('₹9999',style: TextStyle( decoration: TextDecoration.lineThrough,decorationColor: Colors.red,),),
                          SizedBox(width: 5),
                          Text(
                            '₹$price',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF2F3645), shape: BoxShape.circle),
                      child: const SizedBox(
                        height: 38,
                        width: 38,
                        child: Icon(
                          Iconsax.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
