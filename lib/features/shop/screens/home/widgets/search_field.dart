import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/store/store.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9, top: 8),
      child: GestureDetector(
        onTap: () => Get.to(()=> const StoreScreen()),
        child: TextField(
          
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: 'What are you looking for?',
            prefixIcon: Icon(
              Iconsax.search_normal,
              color: Colors.grey[800],
            ),
          ),
          
        ),
      ),
    );
  }
}