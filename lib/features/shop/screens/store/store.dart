import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/common/cart/cart_icon.dart';
import 'package:kiska/common/product/store_product_column.dart';
import 'package:kiska/features/shop/controllers/category_controller.dart';
import 'package:kiska/features/shop/screens/home/widgets/search_field.dart';
import 'package:kiska/providers/category_provider.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoreScreen extends ConsumerStatefulWidget {
  final int? selectedCategoryIndex;
  const StoreScreen({
    super.key,
    this.selectedCategoryIndex = 1,
  });

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  // Fetching Categories

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
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return DefaultTabController(
      initialIndex: widget.selectedCategoryIndex!,
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DynamicBg.sameBrightness(context),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: MyCartIcon(),
            )
          ],
        ),
        body: categories.isEmpty
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: AppColors.primaryColor, size: 25),
              )
            : NestedScrollView(
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
                              child: SearchField(
                                needBorder: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: AppColors.primaryColor,
                        unselectedLabelColor: Colors.grey,
                        tabAlignment: TabAlignment.start,
                        labelColor: AppColors.primaryColor,
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: categories
                            .map((category) => Tab(child: Text(category.name)))
                            .toList(),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: categories
                      .map((category) =>
                          ProductColumn(categoryId: category.name))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
