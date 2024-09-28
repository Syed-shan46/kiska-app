import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiska/features/shop/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:kiska/utils/constants/image_strings.dart';
import 'package:readmore/readmore.dart';

class MyUserReviewCard extends StatelessWidget {
  const MyUserReviewCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(MyImages.promoBanner1),
                ),
                SizedBox(width: 16),
                Text(name, style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),

        SizedBox(height: 16),

        // User Review
        Row(
          children: [
            MyRatingBarIndicator(rating: 4),
            SizedBox(
              width: 16,
            ),
            Text('02 Nov 2024', style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),

        // User Description
        SizedBox(height: 16),
        ReadMoreText(
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
          trimLines: 2,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          lessStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 16),

        // Company Review
        Container(
          decoration: BoxDecoration(color: const Color.fromARGB(28, 128, 222, 234),borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KISKA',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text('02 Nov, 2024',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                ReadMoreText(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                  trimLines: 2,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  trimMode: TrimMode.Line,
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
