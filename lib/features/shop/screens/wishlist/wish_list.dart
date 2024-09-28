import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/appbar.dart';
import 'package:kiska/common/product_card.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite',style: TextStyle(color: ThemeUtils.dynamicTextColor(context),fontWeight: FontWeight.w500),),
        actions: const [ 
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(Iconsax.shopping_bag),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
