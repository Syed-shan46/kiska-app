import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Favourite',
          style: TextStyle(
              color: ThemeUtils.dynamicTextColor(context),
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
              onPressed: () => Get.to(() => CartScreen()),
              icon: Icon(Iconsax.shopping_bag),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(''),),
                  Expanded(child: Text(''),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
