import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/home/home.dart';
import 'package:kiska/features/shop/screens/settings/settings.dart';
import 'package:kiska/features/shop/screens/store/store.dart';
import 'package:kiska/features/shop/screens/wishlist/wish_list.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class NavigationMenu extends StatelessWidget {
  // Create an instance of the NavigationController
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: IndexedStack(
            index: navigationController
                .selectedIndex.value, // Use index from GetX controller
            children: navigationController
                .screens, // List of screens to switch between
          ),
          bottomNavigationBar: CustomNavigationBar(
            bubbleCurve: Curves.decelerate,
            selectedColor: AppColors.primaryColor,
            strokeColor: AppColors.primaryColor,
            scaleFactor: 0.2,
            backgroundColor: Navbg.navbarBg(context),
            iconSize: 23,
            onTap: (index) {
              navigationController.changeTabIndex(index);
            },
            currentIndex: navigationController.selectedIndex.value,
            items: [
              CustomNavigationBarItem(
                icon: Icon(Iconsax.home5),
              ),
              CustomNavigationBarItem(
                icon: Icon(Iconsax.shop),
              ),
              CustomNavigationBarItem(
                icon: Icon(Iconsax.heart),
              ),
              CustomNavigationBarItem(
                icon: Icon(Iconsax.user),
              ),
            ],
          ));
    });
  }
}

class NavigationController extends GetxController {
  // Store selected index as an observable
  var selectedIndex = 0.obs;

  // List of screens
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    SettingsScreen(),
  ];

  // Method to change the selected index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
