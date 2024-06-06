import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _FormKey = GlobalKey();

  void validateForgotPassword() {
    if (_FormKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      gradient: AppColors.kGradientSplash,
                    ),
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
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      AppStrings.forgotPasswordStr,
                                      style: AppFonts.kPoppinsMedium.copyWith(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Form(
                                      key: _FormKey,
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                            textLabel: AppStrings.emailStr,
                                            controller: emailController,
                                            hintText: AppStrings.hintEmail,
                                            validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isEmail),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  CustomButton(
                                    label: AppStrings.sendStr,
                                    onClick: validateForgotPassword,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
