import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? screenName;
  void Function()? backClick;
  List<Widget>? actionWidgets;

  CustomAppbar({super.key, this.screenName, this.backClick, this.actionWidgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.kHomeBg,
      title: (screenName != null)
          ? Text(
              screenName!,
              style: AppFonts.kPoppinsMedium.copyWith(fontSize: 20),
            )
          : null,
      leading: IconButton(
        onPressed: backClick ?? () => Navigator.pop(context),
        icon: Icon(
          Icons.keyboard_backspace_rounded,
          color: AppColors.kDarkBlue,
          size: 22,
        ),
      ),
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
