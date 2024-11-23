
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/texts/my_section_heading.dart';
import 'package:kiska/common/image/my_circular_image.dart';
import 'package:kiska/features/shop/screens/settings/profile/widgets/profile_menu_tile.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/utils/constants/image_strings.dart';
import 'package:kiska/utils/constants/sizes.dart';



class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    String email = user?.email ?? '';
    String userName = user?.userName ?? 'Hey User';
    String userId = user?.id ?? '';
    return  Scaffold(
      appBar:  AppBar( 
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(padding:const  EdgeInsets.all(MySizes.defaultSpace),child: Column(
          children: [
            /// profile picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: const [
                   MyCircularImage(image: MyImages.user2, width: 80, height: 80),
                  // TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
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

            
            ProfileMenuTile(title: 'Username',value: userName,onPressed: (){},),
            const SizedBox(height: MySizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: MySizes.spaceBtwItems),

            /// Personal information
            const MySectionHeading(title: 'Personal Information', showActionbutton: false,),
            const SizedBox(height: MySizes.spaceBtwItems),

            ProfileMenuTile(title: 'User Id', value: userId, onPressed: (){},icon: Iconsax.copy,),
            ProfileMenuTile(title: 'E-mail', value: email, onPressed: (){}),
            
           
            const SizedBox(height: MySizes.spaceBtwItems),
            const Divider(),

            /// close account button
            // Center(child: TextButton(
            //   onPressed: (){},
            //   child: const Text('Close Account', style: TextStyle(color: Colors.red),),
            // ),)
          ],
        ),
        ),
      ),
    );
  }
}


