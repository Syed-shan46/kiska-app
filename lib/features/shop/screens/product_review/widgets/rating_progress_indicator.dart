import 'package:flutter/material.dart';
import 'package:kiska/features/shop/screens/product_review/widgets/progress_indicator_and_rating.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400),
          ),
        ),

        Expanded(
          flex: 7,
        child: Column( 
          children: const [ 
            MyRatingProgressIndicator(text: '5', value: 0.5),
            MyRatingProgressIndicator(text: '4', value: 0.3),
            MyRatingProgressIndicator(text: '3', value: 0.4),
            MyRatingProgressIndicator(text: '2', value: 0.6),
            MyRatingProgressIndicator(text: '1', value: 0.7),
          ],
        ))
      ],
    );
  }
}
