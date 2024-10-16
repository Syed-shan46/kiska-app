import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/features/shop/screens/product_review/product_review.dart';
import 'package:kiska/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/services/http_response.dart';
import 'package:kiska/utils/themes/app_colors.dart';
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Text(
            widget.product.productName,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Iconsax.heart,
                color: Colors.red,
              ),
            )
          ],
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBtn(cartProvider: _cartProvider, widget: widget),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Slider
                ProductDetailImages(
                    images: widget.product.images, controller: controller),
                SizedBox(height: 24),

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
        ));
  }
}

class BottomNavigationBtn extends StatelessWidget {
  const BottomNavigationBtn({
    super.key,
    required CartNotifier cartProvider,
    required this.widget,
  }) : _cartProvider = cartProvider;

  final CartNotifier _cartProvider;
  final ProductDetailScreen widget;

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
          OutlinedButton(
            onPressed: () {
              _cartProvider.addProductToCart(
                  productName: widget.product.productName,
                  productPrice: widget.product.productPrice,
                  category: widget.product.category,
                  image: widget.product.images,
                  quantity: widget.product.quantity,
                  productId: widget.product.id);
    
              showSnackBar(context, widget.product.productName);
            },
            child: Text('Add to Cart'),
          ),
          SizedBox(width: 20),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text('Buy Now'))
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
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
            child: Text(
              'Checkout',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
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
      children: const [
        // Rating
        Row(
          children: [
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
        Icon(Icons.share)
      ],
    );
  }
}

// Product Slider
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
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: images.map((imagePath) {
            return Image.network(imagePath);
          }).toList(),
          options: CarouselOptions(
            height: 350,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 1,
            aspectRatio: 16 / 9,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
        ),
        Positioned(
            bottom: 2,
            child: MyDotNavigation(
              controller: controller,
              dotCount: images.length,
            ))
      ],
    );
  }
}
