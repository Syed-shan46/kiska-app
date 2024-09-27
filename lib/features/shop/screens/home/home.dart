import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/appbar.dart';
import 'package:kiska/common/drawer.dart';
import 'package:kiska/common/heading.dart';
import 'package:kiska/common/product_card.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:kiska/features/shop/screens/home/widgets/categories.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  final List<Widget> pages = [
    const Center(child: Text('Home page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Settings page', style: TextStyle(fontSize: 24))),
  ];

  final List<Map<String, String>> products = [
    {'image': 'assets/images/products/pant.png', 'name': 'Pants'},
    {
      'image': 'assets/images/products/NikeBasketballShoeGreenBlack.png',
      'name': 'Shoes'
    },
    {'image': 'assets/images/products/t-shirt.png', 'name': 'T-shirt'},
    {'image': 'assets/images/products/slipper-product.png', 'name': 'Slipper'},
    {'image': 'assets/images/products/laptop.png', 'name': 'Laptop'},
    {'image': 'assets/images/products/pant.png', 'name': 'Pants'},
  ];

  final List<String> categories = [
    "Electronics",
    "Fashion",
    "Home",
    "Beauty",
    "Sports",
    "Books",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: const MyAppBar(
        actionIcon: Iconsax.search_normal_1,
        leadingIcon: 'assets/icons/hamburger.svg',
      ),

      // Drawer
      drawer: const MyDrawer(),

      // Body
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Categories
              Categories(products: products),

              // Banner
              const MyBannerSlider(),

              // Heading
              const MyHeading(headingLeft: "Trending", headingRight: 'See all'),
              const SizedBox(height: 10),

              // Product Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyProductCard(
                        category: "Camera",
                        imageUrl: 'assets/images/products/dash-camera.avif',
                        productName: 'Dash Camera',
                        price: 2000,
                        onTap: () => Get.to(() => ProductDetailScreen()),
                      ),
                    ),
                    Expanded(
                      child: MyProductCard(
                        category: "Clothes",
                        imageUrl: 'assets/images/products/t-shirt.png',
                        productName: 'Adidas Shoe',
                        price: 2000,
                        onTap: () => Get.to(() => ProductDetailScreen()),
                      ),
                    ),
                  ],
                ),
              ),

              // Product card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyProductCard(
                        category: "Shoes",
                        imageUrl:
                            'assets/images/products/NikeBasketballShoeGreenBlack.png',
                        productName: 'Adidas Shoe',
                        price: 2000,
                        onTap: () => Get.to(() => ProductDetailScreen()),
                      ),
                    ),
                    Expanded(
                      child: MyProductCard(
                        category: "Shoe",
                        imageUrl: 'assets/images/products/adidas-shoe.png',
                        productName: 'Adidas Shoe',
                        price: 2000,
                        onTap: () => Get.to(() => ProductDetailScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
