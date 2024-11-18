import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/common/cart/cart_icon.dart';
import 'package:kiska/providers/favorite_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/helpers/box_decoration_helper.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:lottie/lottie.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final wishItemData = ref.watch(favoriteProvider);
    final wishlistProvider = ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Favorites',
          style: TextStyle(
              color: ThemeUtils.dynamicTextColor(context),
              fontWeight: FontWeight.w500),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: MySizes.spaceBtwItems),
              child: MyCartIcon())
        ],
      ),
      body: wishItemData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/e5c80fca-fe94-4bed-9424-e0d70204d1aa/lhGyjYqBYY.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text('Your wishlist is Empty'),
                 
                ],
              ),
            )
          : ListView.builder(
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: SizedBox(
                    width: screenWidth,
                    height: itemHeight, // Ensure a fixed height
                    child: Container(
                      decoration: getDynamicBoxDecoration(context),
                      child: Row(
                        children: [
                          Container(
                            height: imageSize,
                            width: imageSize,
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MySizes.productImageRadius),
                              color: Colors.grey.withOpacity(0.1),
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
                                     
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    wishData.category,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                     
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '₹ ${wishData.productPrice.toString()}',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: InkWell(
                                            onTap: () {
                                              wishlistProvider.removeFavItem(
                                                  wishData.productId);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red.shade400,
                                            )),
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
