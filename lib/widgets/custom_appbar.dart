import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  String? screenName;

  CustomAppbar({super.key, this.screenName});

  @override
  Widget build(BuildContext context) {
   return AppBar(
     centerTitle: true,
      backgroundColor: AppColors.kHomeBg,
      title:(screenName != null) ? Text(
        screenName!,
        style: AppFonts.kPoppinsMedium.copyWith(fontSize: 20),
      ) : null,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.keyboard_backspace_rounded,
          color: AppColors.kDarkBlue,
          size: 22,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
