
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/texts/my_section_heading.dart';
import 'package:kiska/common/appbar/appbar.dart';
import 'package:kiska/common/image/my_circular_image.dart';
import 'package:kiska/features/shop/screens/settings/profile/widgets/profile_menu_tile.dart';
import 'package:kiska/utils/constants/image_strings.dart';
import 'package:kiska/utils/constants/sizes.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(showBackArrow: true,title: Text('Profile'),),
      body: SingleChildScrollView(
        child: Padding(padding:const  EdgeInsets.all(MySizes.defaultSpace),child: Column(
          children: [
            /// profile picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const MyCircularImage(image: MyImages.user, width: 80, height: 80),
                  TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
                ],
              ),
            ),

            /// details
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: MySizes.spaceBtwItems),

            /// heading profile info
            const MySectionHeading(title: 'Profile Information', showActionbutton: false,),
            const SizedBox(height: MySizes.spaceBtwItems),

            ProfileMenuTile(title: 'Name',value: 'Syed shan',onPressed: (){},),
            ProfileMenuTile(title: 'Username',value: 'Syed-shan',onPressed: (){},),
            const SizedBox(height: MySizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: MySizes.spaceBtwItems),

            /// Personal information
            const MySectionHeading(title: 'Personal Information', showActionbutton: false,),
            const SizedBox(height: MySizes.spaceBtwItems),

            ProfileMenuTile(title: 'User Id', value: '785665', onPressed: (){},icon: Iconsax.copy,),
            ProfileMenuTile(title: 'E-mail', value: 'Flutterfire093@gmail.com', onPressed: (){}),
            ProfileMenuTile(title: 'Phone Number', value: '9747304599', onPressed: (){}),
            ProfileMenuTile(title: 'Gender', value: 'Male', onPressed: (){}),
            ProfileMenuTile(title: 'Date of Birth', value: '26 feb, 2001', onPressed: (){}),
            const SizedBox(height: MySizes.spaceBtwItems),
            const Divider(),

            /// close account button
            Center(child: TextButton(
              onPressed: (){},
              child: const Text('Close Account', style: TextStyle(color: Colors.red),),
            ),)
          ],
        ),
        ),
      ),
    );
  }
}


