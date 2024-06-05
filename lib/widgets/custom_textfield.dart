import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.controller,
      this.textLabel,
      this.isPassword = false,
      this.isSecure = false,
      this.prefixIcon,
      this.hintText,
      this.onTogglePassword,
      this.validationCallback,
      this.suffixIcon,
      this.contentPadding,
      this.maxLength,
      this.keyboardType,
      this.minLines,
      this.maxLines,
      this.borderRadius,
      this.onClick,
      this.enabled,
      this.bgColor,
      this.focusBorderSide,
      this.errorText,
      this.onChange});

  final TextEditingController? controller;
  final bool isPassword;
  final bool isSecure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final VoidCallback? onTogglePassword;
  final String? Function(String?)? validationCallback;
  final String? textLabel;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final void Function()? onClick;
  final void Function(String)? onChange;
  bool? enabled;
  Color? bgColor;
  BorderSide? focusBorderSide;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textLabel != null) ...[
          Text(textLabel!, style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16)),
          SizedBox(
            height: 8,
          ),
        ],
        InkWell(
          onTap: onClick,
          child: TextFormField(
            onChanged: onChange,
            enabled: enabled,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            validator: validationCallback,
            controller: controller,
            obscureText: isPassword && isSecure,
            cursorColor: AppColors.kDarkBlue,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: maxLines ?? null,
            cursorErrorColor: AppColors.kDarkBlue,
            decoration: InputDecoration(
                fillColor: bgColor,
                filled: bgColor != null,
                contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 40)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 40), borderSide: BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 40), borderSide: focusBorderSide ?? BorderSide(color: AppColors.kDarkBlue)),
                prefixIcon: prefixIcon,
                hintText: hintText,
                errorText: errorText,
                hintStyle: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                suffixIcon: suffixIcon != null
                    ? InkWell(
                        onTap: onTogglePassword,
                        child: suffixIcon,
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
