import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOptView extends StatefulWidget {
  int otpDigit = 4;
  Function(String otp) otpChange;

  CustomOptView({super.key, this.otpDigit = 4, required this.otpChange});

  @override
  State<CustomOptView> createState() => _CustomOptViewState();
}

class _CustomOptViewState extends State<CustomOptView> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.otpDigit,
        (i) {
          return Container(
            width: widget.otpDigit <= 4 ? 60 : 50,
            height: widget.otpDigit <= 4 ? 60 : 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black.withOpacity(0.12),
                )),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(1)],
                cursorColor: AppColors.kDarkBlue,
                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (input) {
                  if (input.isEmpty) {
                    if (i != 0) {
                      otp = otp.substring(0, otp.length - 1);
                      widget.otpChange(otp);
                      FocusScope.of(context).previousFocus();
                    }
                  } else if (input.trim().isNotEmpty && input.trim().length == 1) {
                    otp += input.trim();
                    setState(() {});
                    widget.otpChange(otp);
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            )),
          );
        },
      ),
    );
  }
}
