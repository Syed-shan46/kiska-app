import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/common/widgets/cart/cart_icon.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:kiska/common/drawer.dart';
import 'package:kiska/common/heading.dart';
import 'package:kiska/common/product_card.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:kiska/features/shop/screens/home/widgets/categories.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

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
      

      // Drawer
      drawer: const MyDrawer(),

      // Body
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(

            children: [

              MyHeader(),

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

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyPrimaryHeaderContainer(
      color: DynamicBg.sameBrightness(context),
      showContainer: false,
      height: 130,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: MySizes.defaultSpace),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    /// Left side welcome title
                    Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Good day for shopping',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                ),
                        Text('Syed-shan',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                ),
                      ],
                    ),

                    /// Cart icon
                    Positioned(
                      right: 30,
                      top: 10,
                      child: GestureDetector(
                          onTap: () => Get.to(() => const CartScreen()),
                          child:  MyCartIcon(color: ThemeUtils.dynamicTextColor(context))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}