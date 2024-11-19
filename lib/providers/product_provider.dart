import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/models/product_model.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  void setProducts(List<Product> products) {
    state = products;
  }

  // Method to filter products based on the search query
  List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return state; // If no query, return all products
    }

    return state
        .where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<Product>>((ref) {
  return ProductProvider();
});
