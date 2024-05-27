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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;

  GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? validateEmail(input) {
    if (!Validator().isEmail(input: input!.trim())) {
      return AppStrings.emailError;
    }
    return null;
  }

  String? validatePassword(input) {
    if (!Validator().isStrongPassword(input: input!.trim())) {
      return AppStrings.passwordError;
    }
    return null;
  }

  void togglePassword() {
    isSecure = !isSecure;
    setState(() {});
  }

  void loginUser() {
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login")));
    }
  }

  void navigateRegister() => Navigator.pushNamed(context, Routes.register);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: AppColors.kGradientSplash),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: SvgPicture.asset(AppStrings.svgSmLogo)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          AppStrings.loginStr,
                          style: AppFonts.kPoppinsMedium.copyWith(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
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
                                textLabel: AppStrings.passwordStr,
                                controller: passwordController,
                                hintText: AppStrings.hintPassword,
                                validationCallback: validatePassword,
                                isPassword: true,
                                suffixIcon: Icon(
                                  isSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                onTogglePassword: togglePassword,
                                isSecure: isSecure,
                              ),
                            ],
                          )),
                      Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.forgotPasswordStr,
                                style: AppFonts.kPoppinsMedium.copyWith(
                                  fontSize: 16,
                                  color: AppColors.kDarkBlue,
                                ),
                              ))),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        label: AppStrings.loginStr,
                        onClick: loginUser,
                      ),
                      Spacer(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomRichText(
                            onClick: navigateRegister,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
