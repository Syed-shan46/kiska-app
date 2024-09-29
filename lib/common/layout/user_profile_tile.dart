import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/widgets/image/my_circular_image.dart';


class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key, this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const MyCircularImage(image: 'assets/user/user.png',
            width:
        50,
            height:
        50,padding: 0),
        title: Text('Syed shan', style: Theme.of(context).textTheme
            .labelMedium!.apply(color:Colors.white)),
        subtitle: Text('Flutterfire@gmail.com', style: Theme.of(context)
            .textTheme.labelLarge!.apply(color: Colors.white),),
        trailing: IconButton(onPressed: onPressed,icon: const Icon(Iconsax
            .edit, color: Colors.white),)
    );
  }
}