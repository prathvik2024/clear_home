import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/utils/firebase_provider.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_richtext.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier userCredentials = ValueNotifier("");
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
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Divider(
                                          height: 1,
                                          color: AppColors.kGray,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Or",
                                          style: AppFonts.kPoppinsMedium.copyWith(color: AppColors.kGray),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Divider(
                                          height: 1,
                                          color: AppColors.kGray,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton.icon(
                                      onPressed: () async {
                                        userCredentials.value = await FirebaseProvider.signInWithGoogle();
                                        if (userCredentials.value != null) {
                                          print("logged user: ${userCredentials.value.user!.email}");

                                          SharedPreferences spf = await SharedPreferences.getInstance();
                                          await spf.setString("userName", userCredentials.value.user!.displayName.toString());
                                          if (!await FirebaseProvider.userExists()) {
                                            await FirebaseProvider.createUser();
                                          }
                                          Navigator.pushNamed(context, AppRoutes.dashboard);
                                        }
                                      },
                                      icon: SvgPicture.asset(AppStrings.svgGoogle),
                                      label: Text(
                                        "Sign In with Google",
                                        style: AppFonts.kPoppinsMedium.copyWith(fontSize: 14, color: Colors.black),
                                      ),
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8), side: const BorderSide(color: AppColors.kGray, width: 1))),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
