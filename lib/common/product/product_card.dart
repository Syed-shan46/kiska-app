import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/shimmer/product_shimmer.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/providers/favorite_provider.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class MyProductCard extends ConsumerStatefulWidget {
  const MyProductCard(this.product,
      {
        super.key,
      required this.imageUrl,
      required this.productName,
      required this.price,
      required this.onTap,
      required this.category});

  final String imageUrl;
  final String productName;
  final String category;
  final int price;
  final VoidCallback onTap;
  final Product? product;

  @override
  // ignore: library_private_types_in_public_api
  _MyProductCardState createState() => _MyProductCardState();
}

class _MyProductCardState extends ConsumerState<MyProductCard> {
  bool isAdded = false;
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    // Check if the product is already in the cart and set isAdded accordingly

    final cartState = ref.read(cartProvider);
    final favState = ref.read(favoriteProvider);

    // Check if the product is in the cart
    if (cartState.containsKey(widget.product?.id)) {
      setState(() {
        isAdded = true;
      });
    }

    if (favState.containsKey(widget.product?.id)) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvide = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    final faveState = ref.watch(favoriteProvider);
    final cartState = ref.watch(cartProvider); // Watch for cart state changes
    // Ensure the cart state reflects properly when the cart is updated
    if (cartState.containsKey(widget.product?.id)) {
      setState(() {
        isAdded = true;
      });
    } else {
      setState(() {
        isAdded = false;
      });
    }

    if (faveState.containsKey(widget.product?.id)) {
      setState(() {
        isFavorited = true;
      });
    } else {
      setState(() {
        isFavorited = false;
      });
    }

    return GestureDetector(
      onTap: widget.onTap,
      //box-shadow: rgba(33, 35, 38, 0.1) 0px 10px 10px -10px;
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image loaded successfully
                      } else {
                        // Show a progress indicator while the image is loading
                        return Center(
                          child: ProductShimmer(),
                        );
                      }
                    },
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    height: 120,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons
                          .error); // Optionally, show an error icon if the image fails to load
                    },
                  ),
                  Positioned(
                    child: AnimatedSwitcher(
                      duration: const Duration(
                          milliseconds: 500), // Slow down the transition
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: IconButton(
                        key: ValueKey<bool>(isFavorited),
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                          if (isFavorited) {
                            favoriteProviderData.addProductToFavorite(
                              productName: widget.product!.productName,
                              productPrice: widget.product!.productPrice,
                              quantity: widget.product!.quantity,
                              category: widget.product!.category,
                              image: widget.product!.images,
                              productId: widget.product!.id,
                            );
                          } else {
                            favoriteProviderData
                                .removeFavItem(widget.product!.id);
                          }
                        },
                        icon: Icon(
                          isFavorited ? Iconsax.heart5 : Iconsax.heart,
                          color: isFavorited
                              ? Colors.red
                              : ThemeUtils.dynamicTextColor(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Category
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              // Product name
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.productName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ThemeUtils.dynamicTextColor(context),
                  ),
                ),
              ),

              // Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Row(
                      children: [
                        Text(
                          '₹9999',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '₹${widget.price}',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: ThemeUtils.dynamicTextColor(context)),
                        ),
                      ],
                    ),
                  ),
                  // Cart Button
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAdded = !isAdded; // Toggle the button state on tap
                          if (isAdded) {
                            // Add to cart
                            cartProvide.addProductToCart(
                              productName: widget.product!.productName,
                              productPrice: widget.product!.productPrice,
                              quantity: widget.product!.quantity,
                              category: widget.product!.category,
                              image: widget.product!.images,
                              productId: widget.product!.id,
                            );
                          } else {
                            // Remove from cart
                            cartProvide.removeCartItem(widget.product!.id);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                            milliseconds: 500), // Smooth color transition
                        decoration: BoxDecoration(
                          color: isAdded
                              ? AppColors.primaryColor
                              : const Color(0xFF2F3645), // Animate color change
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: AnimatedSwitcher(
                            duration: Duration(
                                milliseconds: 300), // Smooth icon transition
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: Icon(
                              isAdded
                                  ? Icons.check
                                  : Iconsax
                                      .add, // Change to tick/check icon if clicked
                              key: ValueKey<bool>(
                                  isAdded), // Ensures unique keys for icon changes
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
