import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../routes/routes.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: AppColors.kGradientSplash),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: IconButton(
                              onPressed: () =>Navigator.pop(context),
                              icon: Icon(
                                Icons.keyboard_backspace_outlined,
                                color: Colors.white,
                              )),
                        ),
                        Center(child: SvgPicture.asset(AppStrings.svgSmLogo)),
                      ],
                    )),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.verificationStr,
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 22),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                AppStrings.verificationMsgStr,
                                textAlign: TextAlign.center,
                                style: AppFonts.kPoppinsRegular.copyWith(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          SvgPicture.asset(AppStrings.svgPending),
                          SizedBox(
                            height: 20,
                          ),
                          CustomRichText(
                            onClick: () {},
                            firstText: AppStrings.statusStr,
                            secondText: AppStrings.pendingStr,
                            secondTextStyle: AppFonts.kPoppinsSemiBold.copyWith(color: AppColors.kYellow),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(label: AppStrings.refreshStr, onClick: () {}),
                          Spacer(),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomRichText(
                                onClick: () => Navigator.pushNamed(context, AppRoutes.login),
                                firstText: AppStrings.alreadyAccountStr,
                                secondText: AppStrings.loginStr,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
