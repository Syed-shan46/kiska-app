import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/common/product/product_card.dart';
import 'package:kiska/features/shop/controllers/product_controller.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductColumn extends ConsumerWidget {
  final String categoryId;

  const ProductColumn({super.key, required this.categoryId});

  Future<List<Product>> _fetchProductsByCategory(String categoryId) async {
    final ProductController productController = ProductController();
    return await productController.loadProductsByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ProductController();

    return FutureBuilder<List<Product>>(
        future: productController.loadProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.primaryColor, size: 25));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No products found in this category.'));
          }

          final products = snapshot.data!;

          return GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return MyProductCard(product,
                    imageUrl: product.images[0],
                    productName: product.productName,
                    price: product.productPrice, onTap: () {
                  Get.to(() => ProductDetailScreen(product: product));
                }, category: product.category);
              });
        });
  }
}
