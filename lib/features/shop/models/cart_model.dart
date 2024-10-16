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
}
