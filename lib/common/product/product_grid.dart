import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/common/product/product_card.dart';
import 'package:kiska/features/shop/controllers/product_controller.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/providers/product_provider.dart';

class MyProductGrid extends ConsumerStatefulWidget {
  const MyProductGrid({super.key});

  @override
  ConsumerState<MyProductGrid> createState() => _MyProductGridState();
}

class _MyProductGridState extends ConsumerState<MyProductGrid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
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
  }
}
