import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.controller,
      this.textLabel,
      this.isSecure = false,
      this.prefixIcon,
      this.hintText,
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
      this.onChange,
      this.readOnly = false});

  final TextEditingController? controller;
  final bool isSecure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
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
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textLabel != null) ...[
          Text(textLabel!, style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16)),
          const SizedBox(
            height: 8,
          ),
        ],
        TextFormField(
          onTap: onClick,
          onChanged: onChange,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType,
          validator: validationCallback,
          controller: controller,
          readOnly: readOnly,
          obscureText: isSecure,
          cursorColor: AppColors.kDarkBlue,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          cursorErrorColor: AppColors.kDarkBlue,
          decoration: InputDecoration(
              fillColor: bgColor,
              filled: bgColor != null,
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 40)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 40), borderSide: const BorderSide(color: Colors.black12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 40),
                  borderSide: focusBorderSide ?? const BorderSide(color: AppColors.kDarkBlue)),
              prefixIcon: prefixIcon,
              hintText: hintText,
              errorText: errorText,
              hintStyle: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
              suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
