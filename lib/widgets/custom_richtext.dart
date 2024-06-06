import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {

  void Function()? onClick;
  String firstText, secondText;
  TextStyle? firstTextStyle, secondTextStyle;

  CustomRichText({super.key, this.onClick, required this.firstText, required this.secondText, this.firstTextStyle, this.secondTextStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: firstText,
            style: firstTextStyle ?? AppFonts.kPoppinsRegular.copyWith(color: AppColors.kLightBlack),
            children: [TextSpan(text: secondText,recognizer: TapGestureRecognizer()..onTap = onClick, style: secondTextStyle ?? AppFonts.kPoppinsMedium.copyWith(color: AppColors.kDarkBlue))]));
  }
}
