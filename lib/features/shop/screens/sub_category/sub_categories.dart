import 'package:flutter/material.dart';
import 'package:kiska/common/product_card/product_card_horizontal.dart';
import 'package:kiska/common/texts/my_section_heading.dart';
import 'package:kiska/utils/constants/sizes.dart';


class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:  Text('Categories',),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              MySectionHeading(title: 'Sports Shirts'),
              SizedBox(height: MySizes.spaceBtwItems),
              MyHorizontalBuilder(),
              SizedBox(height: MySizes.spaceBtwItems),

              MySectionHeading(title: 'Sports Equipments'),
              SizedBox(height: MySizes.spaceBtwItems),
              MyHorizontalBuilder(),
              SizedBox(height: MySizes.spaceBtwItems),

              MySectionHeading(title: 'Sports Equipments'),
              SizedBox(height: MySizes.spaceBtwItems),
              MyHorizontalBuilder(),
              SizedBox(height: MySizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHorizontalBuilder extends StatelessWidget {
  const MyHorizontalBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: MySizes.spaceBtwItems),
          itemBuilder: (context, index) => const MyProductCardHorizontal()),
    );
  }
}
