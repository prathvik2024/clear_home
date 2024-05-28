import 'package:clear_home/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';
import '../../constants/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isSecure = true;
  bool isConfirmPassSecure = true;

  String? validateConfirmPassword(input) {
    if (input.toString().isEmpty || passwordController.text.trim() != input) {
      return AppStrings.confirmPasswordError;
    }
    return null;
  }
  void validateNewPassword(){
    if(_formKey.currentState!.validate()){
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => route.settings.name == AppRoutes.login,);
    }
  }

  String? validatePassword(input) {
    if (!Validator.isStrongPassword(input: input!.trim())) {
      return AppStrings.passwordError;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                onPressed: ()=>Navigator.pop(context),
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
                    height: MediaQuery.of(context).size.height * 0.66,
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
                              AppStrings.createNewPasswordStr,
                              style: AppFonts.kPoppinsMedium.copyWith(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    textLabel: AppStrings.newPasswordStr,
                                    controller: passwordController,
                                    hintText: AppStrings.hintPassword,
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
                              )),
                          SizedBox(
                            height: 60,
                          ),
                          CustomButton(
                            label: AppStrings.saveStr,
                            onClick: validateNewPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );;
  }
}
