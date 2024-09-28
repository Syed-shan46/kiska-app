import 'package:flutter/material.dart';
import 'package:kiska/features/shop/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:kiska/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:kiska/features/shop/screens/product_review/widgets/user_review.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews & Ratings',
          style: TextStyle(color: ThemeUtils.dynamicTextColor(context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
              ),
              SizedBox(height: 16),
              
              // Rating bar
              RatingProgressIndicator(),
              MyRatingBarIndicator(rating: 3.8),
              Text('12,322',style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 32),

              // User review list
              MyUserReviewCard(name: 'Jhon Doe'),
              SizedBox(height: 20),
              MyUserReviewCard(name: 'Some One'),
            ],
          ),
        ),
      ),
    );
  }
}
