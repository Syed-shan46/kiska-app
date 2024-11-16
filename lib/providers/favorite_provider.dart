import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/models/wishlist.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String productName,
    required final int productPrice,
    required final String category,
    required final List<String> image,
    required final int quantity,
    required final String productId,
  }) {
    state = {
      ...state,
      productId: Favorite(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          quantity: 1, // Set default quantity to 1
          productId: productId),
    };
  }

  void removeFavItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  Map<String, Favorite> get getFavItems => state;
}
