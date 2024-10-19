import 'dart:convert';

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/common/widgets/cart/cart_icon.dart';
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/cart_model.dart';
import 'package:kiska/features/shop/screens/address/address.dart';
import 'package:kiska/features/shop/screens/checkout/checkout.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double getEachTotal(Map<String, Cart> cartData) {
    double eachTotal = 0.0;
    cartData.forEach((key, cartItem) {
      eachTotal += cartItem.totalPrice; // Use the totalPrice method
    });
    return eachTotal;
  }

  double getTotalAmount(Map<String, Cart> cartData) {
    double total = 0.0;
    cartData.forEach((key, cartItem) {
      total += cartItem.productPrice * cartItem.quantity; // Calculate total
    });
    return total;
  }

  //Checking if already address is on Db
  bool addressExists = false;

  // Check if the user has an address saved in the database
  Future<void> checkUserAddress(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      try {
        // Call your backend API to check if the user has an address saved
        http.Response response = await http.get(
          Uri.parse(
              '$uri/api/check-address/$userId'), // Your address-checking API
        );

        if (response.statusCode == 200) {
          setState(() {
            addressExists = jsonDecode(response.body)[
                'addressExists']; // This depends on your API response structure
          });

          if (addressExists) {
            // If address exists, navigate to checkout screen
            Get.to(() => CheckoutScreen());
          } else {
            // If no address exists, navigate to address screen
            Get.to(() => AddressScreen());
          }
        } else {
          // Handle error case (API response is not OK)
          print('Error: Failed to check address');
          setState(() {});
        }
      } catch (e) {
        print('Error checking address: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.watch(cartProvider.notifier);
    final totalAmount = getTotalAmount(cartData);
    getEachTotal(cartData);

    return Scaffold(
      /// Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 22,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: MyCartIcon(),
          )
        ],
      ),

      // Checkout button
      bottomNavigationBar: cartData.isEmpty
          ? PurchaseBtn()
          : Padding(
              padding: EdgeInsets.all(MySizes.defaultSpace),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => checkUserAddress(context),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  child: Text(
                    'Checkout ₹$totalAmount',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: DynamicBg.sameBrightness(context)),
                  ),
                ),
              ),
            ),

      /// Heading and cart items
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/e5c80fca-fe94-4bed-9424-e0d70204d1aa/lhGyjYqBYY.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text('Shopping Cart is Empty'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Text
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 10),
                    child: Text('check and pay items'),
                  ),

                  /// Cart items card
                  Padding(
                    padding: EdgeInsets.all(MySizes.defaultSpace),
                    child: ListView.separated(
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
                              color: Colors.transparent,
                              border: Border.all(
                                  color: ThemeUtils.dynamicTextColor(context)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// Categories
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 0),
                                                child: Text(cartItem.category),
                                              )
                                            ],
                                          ),

                                          /// Price
                                          Row(
                                            children: [
                                              Text(
                                                '₹${cartItem.totalPrice}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )),

                                      const SizedBox(height: 2),

                                      /// Quantity
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () => _cartProvider
                                                      .removeCartItem(
                                                          cartItem.productId),
                                                  child: Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _cartProvider
                                                      .DecrementCartItem(
                                                          cartItem.productId);
                                                },
                                                child: const Icon(
                                                  Icons.remove_circle_outline,
                                                  size: 19,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  cartItem.quantity.toString()),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _cartProvider
                                                      .IncrementCartItem(
                                                          cartItem.productId);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .add_circle_outline_outlined,
                                                  size: 19,
                                                  color: Colors.blue
                                                      .withOpacity(0.8),
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
                    ),
                  ),

                  Divider(
                      color: Colors.grey.withOpacity(0.3),
                      indent: 20,
                      endIndent: 20),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  /// Coupon box

                  const SizedBox(height: MySizes.spaceBtwItems),

                  /// Price details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('*FREE Delivery available only India'),
                        const SizedBox(height: MySizes.spaceBtwItems),
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_cartProvider.totalQuantity} items'),
                            Text(
                              '₹$totalAmount',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Coupon Offer'),
                            Text(
                              '- \$00.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                            )
                          ],
                        ),

                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery Fee'),
                            Text(
                              '+ 00.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                            )
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ),

                        /// Total Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${totalAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class PurchaseBtn extends StatelessWidget {
  const PurchaseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MySizes.defaultSpace),
      child: Bounce(
        tiltAngle: BorderSide.strokeAlignInside,
        filterQuality: FilterQuality.high,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => NavigationMenu());
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            child: Text(
              'Purchase now',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: DynamicBg.sameBrightness(context)),
            ),
          ),
        ),
      ),
    );
  }
}

class CouponBox extends StatelessWidget {
  const CouponBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
      child: SizedBox(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Your Coupon Code',
                  filled: true,
                  fillColor: AppColors.primaryColor.withOpacity(0.1),
                  prefixIcon: Icon(
                    Icons.discount_outlined,
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            )
          ],
        ),
      ),
    );
  }
}
