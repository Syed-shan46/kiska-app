import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';

class MyDotNavigation extends StatelessWidget {
  const MyDotNavigation({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.carousalCurrentIndex.value == i
                        ? const Color.fromARGB(255, 45, 197, 88)
                        : Colors.grey,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                )
            ],
          ),
        )
      ],
    );
  }
}
