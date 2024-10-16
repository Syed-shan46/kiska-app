import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/category_controller.dart';
import 'package:kiska/features/shop/models/category_model.dart';
import 'package:kiska/features/shop/screens/sub_category/sub_categories.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories =
        CategoryController().loadCategories(); // Load categories from backend
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: const Center(child: CircularProgressIndicator()),
          ); // Show loading spinner
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}')); // Show error message
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No categories available')); // Handle empty state
        }

        final categories = snapshot.data!;

        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(() => SubCategoriesScreen()),
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
                            // Load image from network instead of assets
                            child: Image.network(
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image loaded successfully
                                } else {
                                  // Show a progress indicator while the image is loading
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child:
                                          LoadingAnimationWidget.stretchedDots(
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                }
                              },
                              category
                                  .image, // Assuming Category model has imageUrl field
                              width: 45,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                    Icons.error); // Error fallback
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(category.name), // Show category name
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
