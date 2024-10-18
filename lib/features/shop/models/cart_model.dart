class Cart {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  int quantity;
  final String productId;

  Cart(
      {required this.productName,
      required this.productPrice,
      required this.category,
      required this.image,
      required this.quantity,
      required this.productId});

      // Method to increment the quantity
  void increment() {
    quantity++;
  }

  // Method to decrement the quantity
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  // Calculate total price based on quantity
  int get totalPrice => productPrice * quantity;

      // Add the copyWith method
  Cart copyWith({
    String? productId,
    String? productName,
    String? category,
    List<String>? image,
    int? productPrice,
    int? quantity,
  }) {
    return Cart(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      image: image ?? this.image,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
