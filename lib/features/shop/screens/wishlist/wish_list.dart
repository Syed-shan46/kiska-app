import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/appbar.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(actionIcon: Iconsax.shopping_bag,),
      
    );
  }
}
