import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';
import 'package:kiska/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:kiska/utils/constants/image_strings.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  // Sample images
  final List<String> images = [
    MyImages.productImg2,
    MyImages.productImg3,
    MyImages.productImg2,
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Iconsax.heart,
                color: Colors.red,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBtn(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProductDetailImages(images: images, controller: controller),
            ],
          ),
        ));
  }
}

class ProductDetailImages extends StatelessWidget {
  const ProductDetailImages({
    super.key,
    required this.images,
    required this.controller,
  });

  final List<String> images;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: images.map((imagePath) {
            return Image.asset(imagePath);
          }).toList(),
          options: CarouselOptions(
            height: 350,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 1,
            aspectRatio: 16/9,
            onPageChanged: (index, _) =>
                controller.updatePageIndicator(index),
          ),
        ),
        Positioned(
            bottom: 2, child: MyDotNavigation(controller: controller))
      ],
    );
  }
}

// BottomNavigation buttons
class BottomNavigationBtn extends StatelessWidget {
  const BottomNavigationBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      // Add to Cart and Buy Now Button
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {},
            child: Text('Add to Cart'),
          ),
          SizedBox(width: 20),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text('Buy Now'))
        ],
      ),
    );
  }
}
