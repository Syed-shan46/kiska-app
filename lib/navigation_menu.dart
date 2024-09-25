import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/features/shop/screens/home/home.dart';
import 'package:kiska/features/shop/screens/settings/settings.dart';
import 'package:kiska/features/shop/screens/store/store.dart';
import 'package:kiska/features/shop/screens/wishlist/wish_list.dart';


class NavigationMenu extends StatelessWidget {
  // Create an instance of the NavigationController
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: navigationController.selectedIndex.value, // Use index from GetX controller
          children: navigationController.screens, // List of screens to switch between
        ),
        bottomNavigationBar: NavigationBar(
          height: 60,
          elevation: 0,
          indicatorColor: Theme.of(context).colorScheme.primary,
          selectedIndex: navigationController.selectedIndex.value, // Use index from GetX controller
          onDestinationSelected: (index) {
            navigationController.changeTabIndex(index); // Call method to change tab
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home5), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      );
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
    const SettingsScreen(),
  ];

  // Method to change the selected index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
