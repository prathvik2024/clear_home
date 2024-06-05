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

  GlobalKey<FormState> _registerFormKey = GlobalKey();

  String? validateEmail(input) {
    if (!Validator.isEmail(input: input!.trim())) {
      return AppStrings.emailError;
    }
    return null;
  }

  String? validateFullName(input) {
    if (!Validator.isAlpha(input: input!.trim())) {
      return AppStrings.nameError;
    }
    return null;
  }

  String? validatePassword(input) {
    if (!Validator.isStrongPassword(input: input!.trim())) {
      return AppStrings.passwordError;
    }
    return null;
  }

  String? validatePhone(input) {
    if (!Validator.isPhone(input: input!.trim())) {
      return AppStrings.phoneError;
    }
    return null;
  }

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
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: AppColors.kGradientSplash),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: SvgPicture.asset(AppStrings.svgSmLogo)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                        SizedBox(
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
                                validationCallback: validateFullName,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                textLabel: AppStrings.emailStr,
                                controller: emailController,
                                hintText: AppStrings.hintEmail,
                                validationCallback: validateEmail,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                textLabel: AppStrings.mobileStr,
                                controller: mobileController,
                                hintText: AppStrings.hintPhone,
                                validationCallback: validatePhone,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                textLabel: AppStrings.newPasswordStr,
                                controller: passwordController,
                                hintText: AppStrings.hintPassword,
                                maxLines: 1,
                                validationCallback: validatePassword,
                                isPassword: true,
                                suffixIcon: Icon(
                                  isSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                onTogglePassword: () {
                                  isSecure = !isSecure;
                                  setState(() {});
                                },
                                isSecure: isSecure,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                textLabel: AppStrings.confirmPasswordStr,
                                controller: confirmPasswordController,
                                hintText: AppStrings.hintPassword,
                                maxLines: 1,
                                validationCallback: validateConfirmPassword,
                                isPassword: true,
                                suffixIcon: Icon(
                                  isConfirmPassSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                onTogglePassword: () {
                                  isConfirmPassSecure = !isConfirmPassSecure;
                                  setState(() {});
                                },
                                isSecure: isConfirmPassSecure,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          label: AppStrings.signUpStr,
                          onClick: registerUser,
                        ),
                        SizedBox(
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
            ),
          )),
    );
  }
}
