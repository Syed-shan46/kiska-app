import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/screens/login/login.dart';
import 'package:kiska/navigation_menu.dart';


class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // update current index & jump to the next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(() =>  NavigationMenu());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void prevPage() {
    int prevPage = currentPageIndex.value -1;
    pageController.jumpToPage(prevPage);
  }

  // update current index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
