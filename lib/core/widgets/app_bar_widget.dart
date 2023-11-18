import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? elevation;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWidget({
    Key? key,
    required this.title,
    this.backgroundColor = kAppbarColor,
    this.textStyle = const TextStyle(color: kDarkBlueColor),
    this.elevation = 0,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: textStyle,
      ),
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
