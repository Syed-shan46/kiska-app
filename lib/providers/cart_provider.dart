import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/models/cart_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  // Method to add product to the cart
  void addProductToCart({
    required String productName,
    required final int productPrice,
    required final String category,
    required final List<String> image,
    required final int quantity,
    required final String productId,
  }) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: Cart(
            productName: state[productId]!.productName,
            productPrice: state[productId]!.productPrice,
            category: state[productId]!.category,
            image: state[productId]!.image,
            quantity: state[productId]!.quantity + 1,
            productId: productId),
      };
    } else {
      state = {
        productId: Cart(
            productName: productName,
            productPrice: productPrice,
            category: category,
            image: image,
            quantity: quantity,
            productId: productId),
      };
    }
  }

  void IncrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      state = {...state};
    }
  }

  void DecrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      state = {...state};
    }
  }

  void removeCartItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}
