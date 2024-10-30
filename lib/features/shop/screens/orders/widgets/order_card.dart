import 'package:flutter/material.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/helpers/box_decoration_helper.dart';
import 'package:kiska/utils/themes/app_colors.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar()
    ;
  }
}
