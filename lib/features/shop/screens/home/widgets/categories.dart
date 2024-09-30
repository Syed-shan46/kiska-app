import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/screens/sub_category/sub_categories.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.products,
  });

  final List<Map<String, String>> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Get.to(()=> SubCategoriesScreen()),
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(product['image']!,
                            width: 45, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(product['name']!),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}