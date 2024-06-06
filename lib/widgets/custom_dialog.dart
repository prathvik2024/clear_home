import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDialog extends StatelessWidget {
  String? title, negativeButtonName, positiveButtonName, lottie;
  VoidCallback? negativeOnclick, positiveOnclick;

  CustomDialog({super.key, this.title, this.negativeButtonName, this.positiveButtonName, this.negativeOnclick, this.positiveOnclick, this.lottie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 35,
            left: 25,
            right: 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lottie != null) ...[
                Lottie.asset(lottie!, width: 200, height: 200),
                const SizedBox(
                  height: 25,
                ),
              ],
              if (title != null) ...[
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppFonts.kPoppinsRegular.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (negativeOnclick != null) ...[
                    SizedBox(
                        width: width * 0.25,
                        child: OutlinedButton(
                          onPressed: negativeOnclick,
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.kDarkBlue,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                30,
                              ))),
                          child: Text(
                            negativeButtonName ?? AppStrings.noButtonStr,
                            style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                          ),
                        )),
                  ],
                  const SizedBox(
                    width: 10,
                  ),
                  if (positiveOnclick != null) ...[
                    SizedBox(
                        width: width * 0.25,
                        child: OutlinedButton(
                          onPressed: positiveOnclick,
                          style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.kLiteBlue,
                              side: const BorderSide(color: Colors.transparent),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                30,
                              ))),
                          child: Text(
                            positiveButtonName ?? AppStrings.yesButtonStr,
                            style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
                          ),
                        ))
                  ],
                ],
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
