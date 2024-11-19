import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/search_controller.dart';
import 'package:kiska/features/shop/screens/home/product_detail/product_detail.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class SearchScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeUtils.dynamicTextColor(context)
                            .withOpacity(0.2),
                      ),
                    ),
                    fillColor: Colors.transparent,
                    prefixIcon: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back))),
                autofocus: true,
                onChanged: (query) {
                  // Update the search query when text changes
                  ref.read(searchQueryProvider.notifier).state = query;
                },
              ),
            ),
            if (searchQuery.isEmpty)
              const Text("")
            else
              // Handle the state of the search results using .when
              searchResults.when(
                data: (products) {
                  if (products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          leading: Image.network(product.images[0],
                              width: 50, height: 50),
                          title: Text(product.productName),
                          onTap: () {
                            Get.to(() => ProductDetailScreen(product: product));
                            // Handle product tap (e.g., navigate to product details page)
                          },
                        );
                      },
                    ),
                  );
                },
                loading: () => Center(
                    child:Text('')),
                error: (error, stackTrace) => Center(
                  child: Text('Error loading products: $error'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
