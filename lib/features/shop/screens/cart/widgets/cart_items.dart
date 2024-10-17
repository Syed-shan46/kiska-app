import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/screens/cart/widgets/cart_menu.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class MyCartItems extends ConsumerStatefulWidget {
  const MyCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  _MyCartItemsState createState() => _MyCartItemsState();
}

class _MyCartItemsState extends ConsumerState<MyCartItems> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.watch(cartProvider.notifier);
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
      decoration: BoxDecoration(
          color:AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            /// image
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child:  Image.network(cartItem.image[0],fit: BoxFit.contain,)
            ),

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
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child:  Text(cartItem.category),
                          )
                        ],
                      ),

                      /// Price
                      Row(
                        children: [
                          Text(
                            '₹${cartItem.productPrice}',
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
                      const Row(
                        children: [
                          Text('Qty: 2'),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              _cartProvider.DecrementCartItem(cartItem.productId);
                            },
                            child: const Icon(
                              Icons.remove_circle_outline,
                              size: 19,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                           Text(cartItem.quantity.toString()),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              _cartProvider.IncrementCartItem(cartItem.productId);
                            },
                            child: Icon(
                              Icons.add_circle_outline_outlined,
                              size: 19,
                              color: Colors.blue.withOpacity(0.8),
                            ),
                          ),
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
