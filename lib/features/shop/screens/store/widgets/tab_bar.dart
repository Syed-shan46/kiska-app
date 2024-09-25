  import 'package:flutter/material.dart';
  import 'package:kiska/utils/device/device_utility.dart';

  class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
    const MyTabBar({super.key, required this.tabs});

    final List<Widget> tabs;

    @override
    Widget build(BuildContext context) {
      return Material(
        child: TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            unselectedLabelColor: Colors.grey,
            tabAlignment: TabAlignment.start,
            labelColor: Theme.of(context).colorScheme.secondary,
            dividerHeight: 0,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs),
      );
    }

    @override
    Size get preferredSize => Size.fromHeight(MyDeviceUtils.getAppBarHeight());
  }
