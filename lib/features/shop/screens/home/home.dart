import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/common/product/product_grid.dart';
import 'package:kiska/common/cart/cart_icon.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/common/appbar/drawer.dart';
import 'package:kiska/common/heading.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:kiska/features/shop/screens/home/widgets/categories.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/device/device_utility.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // AppBar

      // Drawer
      drawer: const MyDrawer(),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyPrimaryHeaderContainer(
              showContainer: false,
              color: AppColors.primaryColor,
              child: Column(
                children: const [
                  MyHeader(),
                  SizedBox(height: MySizes.spaceBtwItems),
                  Categories(),
                ],
              ),
            ),

            // Banner
            MyBannerSlider(),

            // Heading
            MyHeading(headingLeft: "Trending", headingRight: 'See all'),

            Padding(
              padding: EdgeInsets.all(6.0),
              child: MyProductGrid(),
            ),
          ],
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
    return SafeArea(
      child: Row(
        children: [
          SizedBox(height: MySizes.spaceBtwItems),
          // Left side with welcome title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: MySizes.defaultSpace / 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Adjusts height to fit content
                children: [
                  Text(
                    'Good Day for shopping',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                  Text(
                    'Syed-shan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ),
          // Cart icon on the right side
          GestureDetector(
            onTap: () => Get.to(() => const CartScreen()),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0), // Consistent padding
              child: MyCartIcon(color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }
}
