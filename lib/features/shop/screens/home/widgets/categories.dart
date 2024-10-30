import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/category_controller.dart';
import 'package:kiska/features/shop/screens/sub_category/sub_categories.dart';
import 'package:kiska/providers/category_provider.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/text_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({super.key});

  @override
  ConsumerState<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {
  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Column(
            children: [
              InkWell(
                onTap: () => Get.to(() => SubCategoriesScreen()),
                child: Container(
                  width: 40.h,
                  height:40.h,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 235, 235),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      category
                          .image, // Assuming Category model has imageUrl field
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image loaded successfully
                        } else {
                          // Show a progress indicator while the image is loading
                          return SizedBox(
                            width: 40.h,
                            height: 40.h,
                            child: Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          );
                        }
                      },
                      width: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error); // Error fallback
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                category.name,
                style: textTheme.bodySmall!.copyWith(color: Colors.white.withOpacity(0.9)),
                
              ), // Show category name
            ],
          );
        },
      ),
    );
  }
}
