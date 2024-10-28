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
    try {
      if (state.containsKey(productId)) {
        // Product already exists in the cart, increment the quantity
        state = {
          ...state,
          productId: Cart(
              productName: state[productId]!.productName,
              productPrice: state[productId]!.productPrice,
              category: state[productId]!.category,
              image: state[productId]!.image,
              quantity: state[productId]!.quantity + 1, // Increment quantity
              productId: productId),
        };
      } else {
        // Product does not exist in the cart, add as new
        state = {
          ...state,
          productId: Cart(
              productName: productName,
              productPrice: productPrice,
              category: category,
              image: image,
              quantity: 1, // Set default quantity to 1
              productId: productId),
        };
      }
    } catch (e) {
      // Handle any errors
      print('Error while updating cart item for product $productId: $e');
    }
  }

  void IncrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      final cartItem = state[productId]!;
      final newQuantity = cartItem.quantity + 1;

      state = {
        ...state,
        productId: cartItem.copyWith(quantity: newQuantity),
      };
    }
  }

  void DecrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      final cartItem = state[productId]!;
      if (cartItem.quantity > 1) {
        // Prevent quantity from going below 1
        final newQuantity = cartItem.quantity - 1;

        state = {
          ...state,
          productId: cartItem.copyWith(quantity: newQuantity),
        };
      }
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

  // Method to calculate the total quantity
  int get totalQuantity {
    return state.values.fold(0, (sum, cartItem) => sum + cartItem.quantity);
  }

  Map<String, Cart> get getCartItems => state;
}
