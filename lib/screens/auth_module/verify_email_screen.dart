import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../routes/routes.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(gradient: AppColors.kGradientSplash),
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.keyboard_backspace_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          Center(child: SvgPicture.asset(AppStrings.svgSmLogo)),
                        ],
                      )),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              AppStrings.verificationStr,
                              style: AppFonts.kPoppinsMedium.copyWith(fontSize: 22),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  AppStrings.verificationMsgStr,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.kPoppinsRegular.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                            SvgPicture.asset(AppStrings.svgPending),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomRichText(
                              onClick: () {},
                              firstText: AppStrings.statusStr,
                              secondText: AppStrings.pendingStr,
                              secondTextStyle: AppFonts.kPoppinsSemiBold.copyWith(color: AppColors.kYellow),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomButton(label: AppStrings.refreshStr, onClick: () {}),
                            const Spacer(),
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
              )),
        ),
      ),
    );
  }
}
