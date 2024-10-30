import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/controllers/order_controller.dart';
import 'package:kiska/features/shop/models/order_model.dart';
import 'package:kiska/providers/order_provider.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/helpers/box_decoration_helper.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final user = ref.read(userProvider);
    if (user != null) {
      final orderController = OrderController();
      try {
        final orders = await orderController.loadOrders(userId: user.id);
        print(user.id);
        print(
            'Fetched orders count: ${orders.length}'); // Debug log for orders count
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        print('Error fetching orders: $e');
      }
    } else {
      print('Error: User is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final orders = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: orders.isEmpty
          ? Center(
              child: Text('No orders found'),
            )
          : Column(
              children: [
                SizedBox(height: MySizes.spaceBtwItems),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final Order order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 75.h,
                          decoration: BoxDecoration(
                            color: DynamicBg.sameBrightness(
                                context), // Base color for the box
                            boxShadow: isDarkMode
                                ? [] // No shadow in dark mode
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.1), // Shadow color for light mode
                                      blurRadius: 50,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                            border: isDarkMode
                                ? Border.all(
                                    color: Colors.white.withOpacity(0.7),
                                    width: 1) // Border for dark mode
                                : null, // No border in light mode
                            borderRadius: BorderRadius.circular(
                                12), // Optional rounded corners
                          ),
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
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(order.image)),

                                const SizedBox(width: MySizes.spaceBtwItems),

                                /// title, price, size
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// Category
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: isDarkMode
                                                        ? AppColors.primaryColor
                                                            .withOpacity(0.8)
                                                        : AppColors.primaryColor
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 0),
                                                child: Text(order.category),
                                              )
                                            ],
                                          ),

                                          /// Price
                                          Row(
                                            children: [
                                              Text(
                                                '₹${order.totalAmount}',
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
                                            order.productName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )),

                                      const SizedBox(height: 2),

                                      /// Quantity
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Row(
                                            children: [
                                              InkWell(
                                                  child: Text(
                                                'Processing',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                child:
                                                    Icon(Iconsax.arrow_right),
                                              )
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
