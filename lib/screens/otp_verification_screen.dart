import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_opt_view.dart';
import 'package:clear_home/widgets/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../routes/routes.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String getOtp = "";
  int otpDigit = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: AppColors.kGradientSplash),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.keyboard_backspace_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          Center(child: SvgPicture.asset(AppStrings.svgSmLogo)),
                        ],
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.70,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.otpVerificationStr,
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 22),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                AppStrings.otpVerificationMsgStr,
                                textAlign: TextAlign.center,
                                style: AppFonts.kPoppinsRegular.copyWith(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          CustomOptView(
                            otpDigit: otpDigit,
                            otpChange: (otp) {
                              getOtp = otp;
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.resendOtpStr,
                                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 15, color: AppColors.kDarkBlue),
                              )),
                          SizedBox(
                            height: 88,
                          ),
                          CustomButton(
                              label: AppStrings.verifyStr,
                              onClick: () {
                                if (getOtp.length < otpDigit) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Please fillup OTP!"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getOtp)));
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
