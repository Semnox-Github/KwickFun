import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/color.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SemnoxAppBar(
      {Key? key,
      this.leading,
      this.title,
      this.actions,
      this.centerTitle,
      this.automaticallyImplyLeading})
      : super(key: key);

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      elevation: 0,
      title: title != null
          ? DefaultTextStyle(
              style: SemnoxTextStyle.h6(context).copyWith(
                color: SemnoxConstantColor.white(context),
              ),
              child: IconTheme.merge(
                  data: IconThemeData(
                    color: SemnoxConstantColor.white(context),
                  ),
                  child: title!))
          : null,
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
