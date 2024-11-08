import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/layouts/settings_menu_tile.dart';
import 'package:kiska/common/layouts/user_profile_tile.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/features/authentication/controllers/auth_controller.dart';
import 'package:kiska/features/shop/screens/address/edit_address.dart';
import 'package:kiska/features/shop/screens/cart/cart.dart';
import 'package:kiska/features/shop/screens/orders/order_screen.dart';
import 'package:kiska/features/shop/screens/settings/profile/profile.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class SettingsScreen extends ConsumerStatefulWidget {

  SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          MyPrimaryHeaderContainer(
            showContainer: false,
            color: AppColors.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  UserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  const SizedBox(
                    height: MySizes.spaceBtwItems,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MySizes.spaceBtwItems),
            child: Column(
              children: [
                // Menu tiles
                InkWell(
                  onTap: () => Get.to(() => EditAddress()),
                  child: MySettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Address',
                      subTitle: 'Shopping delivery address'),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.to(() => CartScreen()),
                  child: MySettingsMenuTile(
                      icon: Iconsax.shopping_bag,
                      title: 'My Cart',
                      subTitle: 'Add, Remove products and move to checkout'),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => OrderScreen());
                  },
                  child: MySettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progresss and Completed Orders'),
                ),
                MySettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account'),
                MySettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all discounted Coupons'),
                MySettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message'),
                MySettingsMenuTile(
                  icon: Iconsax.security_card,
                  title: 'Account Privacy',
                  subTitle: 'Manage data usage and connected accounts',
                ),

                SizedBox(height: MySizes.spaceBtwItems),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        side: WidgetStateProperty.all(
                            BorderSide(color: Colors.red))),
                    onPressed: () async {
                      await authController.signOutUser(context: context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
