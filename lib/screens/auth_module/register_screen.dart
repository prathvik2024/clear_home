import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_richtext.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isSecure = true;
  bool isConfirmPassSecure = true;

  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  String? validateConfirmPassword(input) {
    if (input.toString().isEmpty || passwordController.text.trim() != input) {
      return AppStrings.confirmPasswordError;
    }
    return null;
  }

  void registerUser() {
    if (_registerFormKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.verifyEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: IntrinsicHeight(
                child: Container(
                    decoration: const BoxDecoration(gradient: AppColors.kGradientSplash),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: SvgPicture.asset(AppStrings.svgSmLogo)),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    AppStrings.signUpStr,
                                    style: AppFonts.kPoppinsMedium.copyWith(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: _registerFormKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        textLabel: AppStrings.nameStr,
                                        controller: fullNameController,
                                        hintText: AppStrings.hintName,
                                        validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isAlpha),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        textLabel: AppStrings.emailStr,
                                        controller: emailController,
                                        hintText: AppStrings.hintEmail,
                                        validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isEmail),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        textLabel: AppStrings.mobileStr,
                                        controller: mobileController,
                                        hintText: AppStrings.hintPhone,
                                        validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isPhone),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        textLabel: AppStrings.newPasswordStr,
                                        controller: passwordController,
                                        hintText: AppStrings.hintPassword,
                                        maxLines: 1,
                                        validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isStrongPassword),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            isSecure = !isSecure;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            isSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                            color: Colors.black.withOpacity(0.15),
                                          ),
                                        ),
                                        isSecure: isSecure,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        textLabel: AppStrings.confirmPasswordStr,
                                        controller: confirmPasswordController,
                                        hintText: AppStrings.hintPassword,
                                        maxLines: 1,
                                        validationCallback: validateConfirmPassword,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            isConfirmPassSecure = !isConfirmPassSecure;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            isConfirmPassSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                            color: Colors.black.withOpacity(0.15),
                                          ),
                                        ),
                                        isSecure: isConfirmPassSecure,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomButton(
                                  label: AppStrings.signUpStr,
                                  onClick: registerUser,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CustomRichText(
                                      onClick: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                                      firstText: AppStrings.alreadyAccountStr,
                                      secondText: AppStrings.loginStr,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
