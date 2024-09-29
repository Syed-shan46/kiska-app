import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconsax/iconsax.dart';
class MyCartIcon extends StatelessWidget {
  const MyCartIcon({
    super.key,  this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle:
      const badges.BadgeStyle(padding: EdgeInsets.all(4)),
      position:
      badges.BadgePosition.topEnd(top: -12, end: -6),
      badgeContent: const Text(
        '3',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
      child: Icon(
        Iconsax.shopping_bag,
        color: color,
      ),
    );
  }
}
