import 'package:flutter/material.dart';
import 'package:kiska/common/widgets/cart/cart_icon.dart';
import 'package:kiska/features/shop/screens/home/widgets/search_field.dart';
import 'package:kiska/features/shop/screens/store/widgets/tab_bar.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class StoreScreen extends StatelessWidget {
  
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: DynamicBg.sameBrightness(context),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: MyCartIcon(),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScrolled) {
            return [
              SliverAppBar(
                backgroundColor: DynamicBg.sameBrightness(context),
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SearchField(),
                      )
                    ],
                  ),
                ),
                bottom: const MyTabBar(tabs: [
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Shoes')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Mobiles')),
                  Tab(child: Text('Slippers')),
                ]),
              )
            ];
          },
          body: TabBarView(
            children: const [
              // Product card
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
              ProductColumn(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductColumn extends StatelessWidget {
  const ProductColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:const [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(''),),
                Expanded(child: Text(''),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(''),),
                Expanded(child: Text(''),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
