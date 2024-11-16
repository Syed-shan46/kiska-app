import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/custom_shapes/circular_container.dart';
import 'package:kiska/common/icons/circular_icon.dart';
import 'package:kiska/common/image/my_circular_image.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/providers/favorite_provider.dart';
import 'package:kiska/utils/constants/image_strings.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final wishItemData = ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Favorites',
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
      body: ListView.builder(
        itemCount: wishItemData.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final wishData = wishItemData.values.toList()[index];
          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          double itemHeight = screenHeight * 0.13;
          double imageSize = itemHeight * 0.8;

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              width: screenWidth,
              height: itemHeight, // Ensure a fixed height
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(MySizes.productImageRadius),
                  color: Colors.blue.shade50,
                ),
                child: Row(
                  children: [
                    Container(
                      height: imageSize,
                      width: imageSize,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MySizes.productImageRadius),
                        color: AppColors.primaryColor.withOpacity(0.2),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.network(wishData.image[0]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wishData.productName,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.black.withOpacity(0.9),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  wishData.category,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.black.withOpacity(0.9),
                                  ),
                                ),
                                Icon(
                                  Iconsax.verify5,
                                  size: screenWidth * 0.04,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '₹ ${wishData.productPrice.toString()}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.black.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenWidth * 0.1,
                                  width: screenWidth * 0.1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            MySizes.cardRadiusMd),
                                        bottomRight: Radius.circular(
                                            MySizes.productImageRadius),
                                      ),
                                    ),
                                    child: const Icon(
                                      Iconsax.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
