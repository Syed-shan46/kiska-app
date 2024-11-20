import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/home/home.dart';
import 'package:kiska/features/shop/screens/settings/settings.dart';
import 'package:kiska/features/shop/screens/store/store.dart';
import 'package:kiska/features/shop/screens/wishlist/wish_list_screen.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class NavigationMenu extends ConsumerStatefulWidget {
  @override
  ConsumerState<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends ConsumerState<NavigationMenu> {
  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GNav(
              activeColor: Colors.white.withOpacity(0.8),
              tabBackgroundGradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.5),
                  AppColors.primaryColor.withOpacity(0.9)
                ],
              ),
              padding: const EdgeInsets.all(8),
              selectedIndex: controller.selectedIndex.value,
              onTabChange: controller.changeTabIndex, // Use the method
              gap: 8,
              tabs: const [
                GButton(icon: Iconsax.home5, text: 'Home'),
                GButton(icon: Iconsax.shop, text: 'Store'),
                GButton(icon: CupertinoIcons.heart, text: 'Wish-list'),
                GButton(icon: CupertinoIcons.gear_alt_fill, text: 'Settings'),
              ],
            ),
          ),
        ),
        body: controller.screens[controller.selectedIndex.value],
      );
    });
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    SettingsScreen(),
  ];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
