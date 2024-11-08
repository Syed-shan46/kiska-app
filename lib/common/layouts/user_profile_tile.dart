import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/image/my_circular_image.dart';
import 'package:kiska/providers/user_provider.dart';

class UserProfileTile extends ConsumerStatefulWidget {
  const UserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  ConsumerState<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends ConsumerState<UserProfileTile> {
  @override
  Widget build(BuildContext context) {
     final user = ref.watch(userProvider);
     String userName = user?.userName ?? 'Hey User';
     String email = user?.email ?? 'Your@gmail.com';
    return ListTile(
        leading: const MyCircularImage(
            image: 'assets/images/user/user.png',
            width: 50,
            height: 50,
            padding: 0),
        title: Text(userName,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.white)),
        subtitle: Text(
          email,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: widget.onPressed,
          icon: const Icon(Iconsax.edit, color: Colors.white),
        ));
  }
}
