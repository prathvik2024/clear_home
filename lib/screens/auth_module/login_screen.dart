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

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  void togglePassword() {
    isSecure = !isSecure;
    setState(() {});
  }

  void loginUser() {
    if (_loginFormKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.dashboard);
    }
  }

  void navigateRegister() => Navigator.pushNamed(context, AppRoutes.register);

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
                        Expanded(
                          child: Container(
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
                                      AppStrings.loginStr,
                                      style: AppFonts.kPoppinsMedium.copyWith(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
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
                                            validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isEmail),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomTextField(
                                            textLabel: AppStrings.passwordStr,
                                            controller: passwordController,
                                            hintText: AppStrings.hintPassword,
                                            validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isStrongPassword),
                                            maxLines: 1,
                                            suffixIcon: InkWell(
                                              onTap: togglePassword,
                                              child: Icon(
                                                isSecure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye_rounded,
                                                color: Colors.black.withOpacity(0.15),
                                              ),
                                            ),
                                            isSecure: isSecure,
                                          ),
                                        ],
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                          onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                                          child: Text(
                                            AppStrings.forgotPasswordStr,
                                            style: AppFonts.kPoppinsMedium.copyWith(
                                              fontSize: 16,
                                              color: AppColors.kDarkBlue,
                                            ),
                                          ))),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomButton(
                                    label: AppStrings.loginStr,
                                    onClick: loginUser,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Spacer(),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CustomRichText(
                                        onClick: navigateRegister,
                                        firstText: AppStrings.dontAccountStr,
                                        secondText: AppStrings.signUpStr,
                                      ))
                                ],
                              ),
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
