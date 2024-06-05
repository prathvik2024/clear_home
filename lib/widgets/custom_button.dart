import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String label;
  void Function()? onClick;

  CustomButton({super.key, required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          iconAlignment: IconAlignment.start,
          onPressed: onClick,
          child: Text(
            label,
            style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kLiteBlue, padding: EdgeInsets.all(12), elevation: 4, shadowColor: AppColors.kLiteBlue),
        ));
  }
}
