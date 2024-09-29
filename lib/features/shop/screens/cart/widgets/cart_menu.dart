import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';

class MyCartItem extends StatefulWidget {
  const MyCartItem({
    super.key,
    this.bgColor,
  });

  final Color? bgColor;

  @override
  State<MyCartItem> createState() => _MyCartItemState();
}

class _MyCartItemState extends State<MyCartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor!.withOpacity(0.1),
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
              child: const Image(
                image: AssetImage(
                    'assets/images/products/NikeBasketballShoeGreenBlack.png'),
                fit: BoxFit.contain,
              ),
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
                            child: const Text('Shoes'),
                          )
                        ],
                      ),

                      /// Price
                      Row(
                        children: [
                          Text(
                            '\$200',
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
                        'Nike '
                        'White Shoe',
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
                          const Icon(
                            Icons.remove_circle_outline,
                            size: 19,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(' 02 '),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.add_circle_outline_outlined,
                            size: 19,
                            color: Colors.blue.withOpacity(0.8),
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
  }
}
