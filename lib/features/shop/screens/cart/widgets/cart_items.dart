import 'package:flutter/material.dart';
import 'package:kiska/features/shop/models/category_model.dart';
import 'package:kiska/features/shop/screens/cart/widgets/cart_menu.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';


class MyCartItems extends StatefulWidget {
  const MyCartItems({
    super.key,
     this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  State<MyCartItems> createState() => _MyCartItemsState();
}

class _MyCartItemsState extends State<MyCartItems> {
  List<CategoryModel> categories = [];


  void _getInfo() {
    categories = CategoryModel.getCategories();
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {


    _getInfo();
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Column(
        children: [

          SizedBox(height: MySizes.spaceBtwItems),

        ],
      ),
      itemCount: 3,
      itemBuilder: (_, index) =>  Column(
        children: [
           MyCartItem(bgColor: AppColors.primaryColor.withOpacity(0.1)),
          if(widget.showAddRemoveButtons)const SizedBox(height: MySizes.spaceBtwItems),
          if(widget.showAddRemoveButtons)const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          )

        ],
      ),
    );
  }
}
