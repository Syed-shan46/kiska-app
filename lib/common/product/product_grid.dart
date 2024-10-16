import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/common/product_card.dart';
import 'package:kiska/features/shop/controllers/product_controller.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';

class MyProductGrid extends StatefulWidget {
  const MyProductGrid({super.key});

  @override
  State<MyProductGrid> createState() => _MyProductGridState();
}

class _MyProductGridState extends State<MyProductGrid> {
  final ProductController _productController = ProductController();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureProducts = _productController.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Product Available'),
          );
        }

        final List<Product> products = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                  
                return MyProductCard(
                    imageUrl: product.images[0],
                    productName: product.productName,
                    price: product.productPrice,
                    onTap: () {
                      Get.to(()=> ProductDetailScreen(product: product));
                    },
                    category: product.category)
                    ;
              }),
        );
      },
    );
  }
}
