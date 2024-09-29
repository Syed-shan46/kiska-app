import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';


import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Shopping cart',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w500,)),
        leading: IconButton(onPressed: () => Navigator.pop(context),icon:  Icon
        (Icons
            .arrow_back_ios_new_outlined,size: 22,
        ),),
      ),

      /// Checkout button
      bottomNavigationBar: const MyCartBottomNav(),

      /// Heading and cart items
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Text('check and pay items'),
            ),
        
            /// Cart items card
            const Padding(
              padding: EdgeInsets.all(MySizes.defaultSpace),
              child: MyCartItems(),
            ),
        
            Divider(color: Colors.grey.withOpacity(0.3), indent: 20, endIndent: 20),
            const SizedBox(height: MySizes.spaceBtwItems),
        
            /// Coupon box
            
            const SizedBox(height: MySizes.spaceBtwItems),
        
            /// Price details
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('*FREE Delivery available only India'),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  Text('Price',style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),),
        
                  Divider(color: Colors.grey.withOpacity(0.3), ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('3 Items'),
                      Text('\$600.000',style: Theme.of(context).textTheme
                          .bodyMedium!.copyWith(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Coupon Offer'),
                      Text('- \$00.00',style: Theme.of(context).textTheme
                          .bodyMedium!.copyWith(fontWeight: FontWeight.bold,
                          color: Colors.green),)
                    ],
                  ),
        
                  const SizedBox(height: MySizes.spaceBtwItems /2 ),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Include taxes'),
                      Text('+ 20.00',style: Theme.of(context).textTheme
                          .bodyMedium!.copyWith(fontWeight: FontWeight.bold,
                          color: Colors.red),)
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  Divider(color: Colors.grey.withOpacity(0.3), ),

                  /// Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Total Price',style: Theme.of(context).textTheme
                           .bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
                      Text('\$620.000',style: Theme.of(context).textTheme
                          .bodyMedium!.copyWith(fontWeight: FontWeight.bold,
                          color: Colors.red),)
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

class MyCartBottomNav extends StatelessWidget {
  const MyCartBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          child: Text(
            'Checkout '
            '\$340',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white.withOpacity(0.9)),
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
