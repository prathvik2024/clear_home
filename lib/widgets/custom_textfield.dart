import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.textLabel,
      this.isPassword = false,
      this.isSecure = false,
      this.prefixIcon,
      this.hintText,
      this.onTogglePassword,
      this.validationCallback,
      this.suffixIcon});

  final TextEditingController controller;
  final bool isPassword;
  final bool isSecure;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? hintText;
  final VoidCallback? onTogglePassword;
  final String? Function(String?)? validationCallback;
  final String? textLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textLabel != null) Text(textLabel!, style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16)),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validationCallback,
          controller: controller,
          obscureText: isPassword && isSecure,
          cursorColor: AppColors.kDarkBlue,
          cursorErrorColor: AppColors.kDarkBlue,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide(color: Colors.black12)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide(color: AppColors.kLightBlue)),
              prefixIcon: prefixIcon,
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? InkWell(
                      onTap: onTogglePassword,
                      child: suffixIcon,
                    )
                  : null),
        ),
      ],
    );
  }
}
