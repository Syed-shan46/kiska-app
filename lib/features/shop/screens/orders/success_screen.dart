import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/screens/settings/settings.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Order Recieved',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: MySizes.spaceBtwItems),
              Lottie.network(
                'https://lottie.host/7468eb62-5726-4522-acad-799587cb5a84/CAPyRQ8Ux2.json',
                width: 105.h,
                height: 105.h,
                repeat: true,
              ),
              SizedBox(height: MySizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.spaceBtwSections),
                child: Text(
                  'Thank you for your order, Your items will be with you in the 48 hours',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink to fit the content
          children: [
            InkWell(
              onTap: () => Get.to(()=> SettingsScreen()),
              child: Container(
                color: isDarkMode? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children:  [ 
                    Padding(
                      padding: const EdgeInsets.only(left: MySizes.spaceBtwItems),
                      child: Text('MY ACCOUNT'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
                      child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.arrow_right,),iconSize: 20,),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 2), // Spacing between buttons
            InkWell(
              onTap: () => Get.to(()=> NavigationMenu()),
              child: Container(
                color: isDarkMode? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children:  [ 
                    Padding(
                      padding: const EdgeInsets.only(left: MySizes.spaceBtwItems),
                      child: Text('CONTINUE SHOPPING'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
                      child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.arrow_right,),iconSize: 20,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
