import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {

  void Function()? onClick;

  CustomRichText({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: AppFonts.kPoppinsRegular.copyWith(color: AppColors.kLightBlack),
            children: [TextSpan(text: "Sign up",recognizer: TapGestureRecognizer()..onTap = onClick, style: AppFonts.kPoppinsMedium.copyWith(color: AppColors.kDarkBlue))]));
  }
}
