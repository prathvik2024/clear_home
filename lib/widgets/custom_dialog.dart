import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDialog extends StatelessWidget {
  String? title, negativeButtonName, positiveButtonName, lottie;
  VoidCallback? negativeOnclick, positiveOnclick;

  CustomDialog(
      {super.key, this.title, this.negativeButtonName, this.positiveButtonName, this.negativeOnclick, this.positiveOnclick, this.lottie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.only(
            top: 35,
            left: 25,
            right: 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(lottie != null)...[
              Lottie.asset(lottie!, width: 200, height: 200),SizedBox(
                  height: 25,
                ),],
              if (title != null) ...[
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppFonts.kPoppinsRegular.copyWith(
                    fontSize: 16,
                  ),
                ),SizedBox(
                  height: 25,
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(negativeOnclick != null)...[
                    SizedBox(
                        width: width * 0.25,
                        child: OutlinedButton(
                          onPressed: negativeOnclick,
                          child: Text(
                            negativeButtonName ?? AppStrings.noButtonStr,
                            style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.kDarkBlue,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ))),
                        )),
                  ],
                  SizedBox(
                    width: 10,
                  ),
                  if(positiveOnclick != null)...[SizedBox(
                      width: width * 0.25,
                      child: OutlinedButton(
                        onPressed: positiveOnclick,
                        child: Text(
                          positiveButtonName ?? AppStrings.yesButtonStr,
                          style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.kLiteBlue,
                            side: BorderSide(color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ))),
                      ))],

                ],
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
