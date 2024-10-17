import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/common/product/product_grid.dart';
import 'package:kiska/common/widgets/cart/cart_icon.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/common/widgets/appbar/drawer.dart';
import 'package:kiska/common/heading.dart';
import 'package:kiska/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:kiska/features/shop/screens/home/widgets/categories.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar

      // Drawer
      drawer: const MyDrawer(),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: const [
            MyHeader(),

            // Categories
            Categories(),

            // Banner
            MyBannerSlider(),

            // Heading
            MyHeading(headingLeft: "Trending", headingRight: 'See all'),
            SizedBox(height: 10),

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
    return MyPrimaryHeaderContainer(
      color: DynamicBg.sameBrightness(context),
      showContainer: false,
      height: 120,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: MySizes.defaultSpace / 1.5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    // Left side welcome title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text('Good day for shopping',
                            style: Theme.of(context).textTheme.labelMedium!),
                        Text('Syed-shan',
                            style: Theme.of(context).textTheme.bodyLarge!),
                      ],
                    ),

                    // Cart icon
                    Positioned(
                      right: 20,
                      top: 10,
                      child: GestureDetector(
                          onTap: () => Get.to(() => const CartScreen()),
                          child: MyCartIcon(
                              color: ThemeUtils.dynamicTextColor(context))),
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
