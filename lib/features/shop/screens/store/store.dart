import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/product_card.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/features/shop/screens/home/widgets/search_field.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/features/shop/screens/store/widgets/tab_bar.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          // Changing for testing purpose 
          backgroundColor: Colors.cyan,
          actions: [
            IconButton(onPressed: () => Get.to(()=> CartScreen()),
             icon: Icon(Iconsax.shopping_bag,color: ThemeUtils.dynamicTextColor(context),))
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScrolled) {
            return [
              SliverAppBar(
                backgroundColor: DynamicBg.sameBrightness(context),
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SearchField(),
                      )
                    ],
                  ),
                ),
                bottom: const MyTabBar(tabs: [
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Shoes')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Mobiles')),
                  Tab(child: Text('Slippers')),
                ]),
              )
            ];
          },
          body: TabBarView(
            children: const [
              // Product card
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductColumn extends StatelessWidget {
  const ProductColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
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
                    category: "Mobiles",
                    imageUrl: 'assets/images/products/iphone_13_pro.png',
                    productName: 'Iphone 13 Pro',
                    price: 2000,
                    onTap: () => Get.to(() => ProductDetailScreen()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyProductCard(
                    category: "Mobiles",
                    imageUrl: 'assets/images/products/iphone_13_pro.png',
                    productName: 'Iphone 13 Pro',
                    price: 2000,
                    onTap: () => Get.to(() => ProductDetailScreen()),
                  ),
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
