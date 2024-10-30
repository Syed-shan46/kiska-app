import 'package:flutter/material.dart';
import 'package:kiska/features/shop/models/cart_model.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/helpers/box_decoration_helper.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({
    required this.showQuantity,
    required this.showButtons,
    super.key,
    required this.cartData,
    required CartNotifier cartProvider,
  }) : _cartProvider = cartProvider;

  final Map<String, Cart> cartData;
  final CartNotifier _cartProvider;

  final bool showButtons;
  final bool showQuantity;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Column(
        children: [
          SizedBox(height: MySizes.spaceBtwItems),
        ],
      ),
      itemCount: cartData.length,
      itemBuilder: (context, index) {
        final cartItem = cartData.values.toList()[index];
        return Container(
          decoration: getDynamicBoxDecoration(context),
          width: MediaQuery.of(context).size.width,
          height: 75.h,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                /// image
                Container(
                    width: 65.h,
                    height: 65.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                      cartItem.image[0],
                      fit: BoxFit.contain,
                    )),

                const SizedBox(width: MySizes.spaceBtwItems),

                /// title, price, size
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Categories
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppColors.primaryColor
                                            .withOpacity(0.8)
                                        : AppColors.primaryColor
                                            .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: Text(cartItem.category),
                              )
                            ],
                          ),

                          /// Price
                          Row(
                            children: [
                              Text(
                                '₹${cartItem.totalPrice}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 2),

                      /// Product name
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            cartItem.productName,
                            style: Theme.of(context).textTheme.labelMedium,
                          )),

                      const SizedBox(height: 2),

                      /// Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showButtons
                              ? Row(
                                  children: [
                                    InkWell(
                                        onTap: () => _cartProvider
                                            .removeCartItem(cartItem.productId),
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                )
                              : showQuantity
                                  ? Text(
                                      'Quantity:',
                                    )
                                  : Text('Processing'),
                          Row(
                            children: [
                              showButtons
                                  ? InkWell(
                                      onTap: () {
                                        _cartProvider.DecrementCartItem(
                                            cartItem.productId);
                                      },
                                      child: const Icon(
                                        Icons.remove_circle_outline,
                                        size: 19,
                                      ),
                                    )
                                  : Text(''),
                              const SizedBox(
                                width: 5,
                              ),
                              showButtons
                                  ? Text(cartItem.quantity.toString())
                                  : Text('${cartItem.quantity.toString()}'),
                              const SizedBox(
                                width: 5,
                              ),
                              showButtons
                                  ? InkWell(
                                      onTap: () {
                                        _cartProvider.IncrementCartItem(
                                            cartItem.productId);
                                      },
                                      child: Icon(
                                        Icons.add_circle_outline_outlined,
                                        size: 19,
                                        color: Colors.blue.withOpacity(0.8),
                                      ),
                                    )
                                  : Text(''),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
