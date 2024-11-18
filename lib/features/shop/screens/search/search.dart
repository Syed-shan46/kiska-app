import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
       
        title: SafeArea(
          child: Row(
            children: [
             
              Flexible(
                child: TextField(
                  autofocus: true,
                  focusNode: focusNode,
                  textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(),
                      hintText: 'Search for products',
                      prefixIcon: Icon(
                        Iconsax.search_normal_1,
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
