// ignore_for_file: unused_import, unnecessary_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/custom_shapes/curved_edges_widget.dart';
import 'package:kiska/common/appbar/appbar.dart';
import 'package:kiska/common/cart/cart_icon.dart';
import 'package:kiska/common/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/features/shop/screens/product_review/product_review.dart';
import 'package:kiska/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/services/http_response.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    final controller = Get.put(HomeController());
    return Scaffold(

        // Bottom Navigation Bar
        bottomNavigationBar:
            BottomNavigationBtn(cartProvider: _cartProvider, widget: widget),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProductDetailImages(
                  images: widget.product.images, controller: controller),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image Slider

                    // Product Details
                    ProductDetail(),
                    SizedBox(height: 12),

                    // Price & Sale price
                    ProductPrice(
                      price: widget.product.productPrice,
                    ),
                    SizedBox(height: 12),

                    // Title,
                    Text(widget.product.productName),
                    SizedBox(height: 6),

                    // Stock status
                    StockStatus(),
                    SizedBox(height: 6),

                    // Brand
                    BrandName(),
                    SizedBox(height: 30),

                    // Checkout Button
                    CheckoutButton(),
                    SizedBox(height: 30),

                    // Description
                    Text('Description',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 3),
                    ReadMoreText(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                    ),
                    Divider(
                      thickness: 0.1,
                      height: 10,
                    ),
                    SizedBox(height: 10),

                    // Product Reviews
                    InkWell(
                      onTap: () => Get.to(() => ProductReview()),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reviews'),
                          IconButton(
                              onPressed: () => Get.to(() => ProductReview()),
                              icon: Icon(
                                Iconsax.arrow_right_3,
                                size: 18,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class BottomNavigationBtn extends StatefulWidget {
  const BottomNavigationBtn({
    super.key,
    required CartNotifier cartProvider,
    required this.widget,
  }) : _cartProvider = cartProvider;

  final CartNotifier _cartProvider;
  final ProductDetailScreen widget;

  @override
  State<BottomNavigationBtn> createState() => _BottomNavigationBtnState();
}

class _BottomNavigationBtnState extends State<BottomNavigationBtn> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      // Add to Cart and Buy Now Button
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: OutlinedButton(
              onPressed: () async {
                setState(() {
                  isAdded = true;
                });

                await Future.delayed(Duration(seconds: 2));

                try {
                  widget._cartProvider.addProductToCart(
                    productName: widget.widget.product.productName,
                    productPrice: widget.widget.product.productPrice,
                    category: widget.widget.product.category,
                    image: widget.widget.product.images,
                    quantity: widget.widget.product.quantity,
                    productId: widget.widget.product.id,
                  );
                } finally {
                  setState(() {
                    isAdded = false;
                  });
                }
              },
              child: isAdded
                  ? Lottie.network(
                      'https://lottie.host/7468eb62-5726-4522-acad-799587cb5a84/CAPyRQ8Ux2.json',
                      width: 35,
                      height: 35,
                      repeat: false)
                  : Text('Add to Cart'),
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                'Buy Now',
                style: TextStyle(color: DynamicBg.sameBrightness(context)),
              ))
        ],
      ),
    );
  }
}

// Checkout Button
class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'Checkout',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: DynamicBg.sameBrightness(context)),
            )));
  }
}

// BrandName
class BrandName extends StatelessWidget {
  const BrandName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Kiska'),
        SizedBox(width: 3),
        Icon(
          Iconsax.verify5,
          color: Colors.blue,
          size: 15,
        ),
      ],
    );
  }
}

// StockStatus
class StockStatus extends StatelessWidget {
  const StockStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Status :', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(width: 8),
        Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

// ProductPrice
class ProductPrice extends StatelessWidget {
  final int price;
  const ProductPrice({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Offer
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '25%',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(width: 20),

        // MRP
        Text(
          '9999',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        SizedBox(width: 20),

        // Sale Price
        Text('\$$price', style: TextStyle(fontSize: 22)),
      ],
    );
  }
}

// Product Detail
class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: const [
            Icon(Iconsax.star5, color: Colors.amber, size: 24),
            SizedBox(width: 5),
            Text.rich(
              TextSpan(
                children: [TextSpan(text: '5.0'), TextSpan(text: ' (199)')],
              ),
            ),
          ],
        ),

        // Share Button
        InkWell(
            onTap: () {
              Get.to(() => NavigationMenu());
            },
            child: Icon(Icons.share))
      ],
    );
  }
}

class ProductDetailImages extends StatelessWidget {
  const ProductDetailImages({
    super.key,
    required this.images,
    required this.controller,
  });

  final List<String> images;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return MyCurvedWidget(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Stack(
          children: [
            // Carousel Slider positioned at the base of the stack
            CarouselSlider(
              items: images.map((imagePath) {
                return Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 350.h,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
            ),

            // Positioning the AppBar above the CarouselSlider
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(
                showBackArrow: true,
                actions: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle),
                    child: InkWell(
                        child: const Icon(CupertinoIcons.suit_heart,
                            color: Colors.red)),
                  )
                ],
              ),
            ),

            // Dot navigation at the bottom of the image
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: MyDotNavigation(
                controller: controller,
                dotCount: images.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
