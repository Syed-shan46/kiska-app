import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/providers/cart_provider.dart';
class MyCartIcon extends ConsumerStatefulWidget {
  const MyCartIcon({
    super.key,  this.color,
  });

  final Color? color;

  @override
  _MyCartIconState createState() => _MyCartIconState();
}

class _MyCartIconState extends ConsumerState<MyCartIcon> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    return badges.Badge(
      badgeStyle:
      const badges.BadgeStyle(padding: EdgeInsets.all(4)),
      position:
      badges.BadgePosition.topEnd(top: -12, end: -6),
      badgeContent:  Text(
        cartData.length.toString(),
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
      child: Icon(
        Iconsax.shopping_bag,
        color: widget.color,
      ),
    );
  }
}
