import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/texts/my_section_heading.dart';
import 'package:kiska/common/widgets/appbar/appbar.dart';
import 'package:kiska/common/widgets/layouts/settings_menu_tile.dart';
import 'package:kiska/common/widgets/layouts/user_profile_tile.dart';
import 'package:kiska/common/custom_shapes/primary_header_container.dart';
import 'package:kiska/features/shop/screens/settings/profile/profile.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          MyPrimaryHeaderContainer(
            color: AppColors.primaryColor,
            height: 220,
            child: Column(
              children: [
                MyAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: Colors.white),
                  ),
                ),
                UserProfileTile(
                  onPressed: () => Get.to(() => ProfileScreen()),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MySizes.spaceBtwItems),
            child: Column(
              children: [
                // Account settings
                MySectionHeading(
                  title: 'Account Settings',
                  textColor: Colors.red,
                  showActionbutton: false,
                ),
                SizedBox(height: MySizes.spaceBtwItems),

                // Menu tiles
                MySettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Address',
                    subTitle: 'Shopping delivery address'),
                MySettingsMenuTile(
                    icon: Iconsax.shopping_bag,
                    title: 'My Cart',
                    subTitle: 'Add, Remove products and move to checkout'),
                MySettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progresss and Completed Orders'),
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
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        side: WidgetStateProperty.all(
                            BorderSide(color: Colors.red))),
                    onPressed: () {},
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
