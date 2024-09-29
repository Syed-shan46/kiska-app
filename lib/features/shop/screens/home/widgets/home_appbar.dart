import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/screens/search/search.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.leadingIcon,
     this.actionIcon,
     this.title,
  });

  final String? leadingIcon;
  final IconData? actionIcon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DynamicBg.sameBrightness(context),
      leading:leadingIcon != null ? Builder(builder: (BuildContext context) {
        return InkWell(
          onTap: Scaffold.of(context).openDrawer,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: SizedBox(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: SvgPicture.asset(
                leadingIcon!,
                color: ThemeUtils.dynamicTextColor(context),
              ),
            ),
          ),
        );
      }) : null,
      actions: actionIcon != null ? <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => Get.to(() => SearchScreen()),
            icon: Icon(actionIcon, size: 22),
            color: ThemeUtils.dynamicTextColor(context),
          ),
        ),
      ] : <Widget>[],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
