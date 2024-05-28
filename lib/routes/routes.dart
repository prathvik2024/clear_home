import 'package:clear_home/screens/forgot_password_screen.dart';
import 'package:clear_home/screens/login_screen.dart';
import 'package:clear_home/screens/new_password_screen.dart';
import 'package:clear_home/screens/otp_verification_screen.dart';
import 'package:clear_home/screens/register_screen.dart';
import 'package:clear_home/screens/splash_screen.dart';
import 'package:clear_home/screens/verify_email_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  static const String splash  = "/";
  static const String login  = "/login";
  static const String register  = "/register";
  static const String verifyEmail  = "/verifyEmail";
  static const String forgotPassword  = "/forgotPassword";
  static const String otpVerification  = "/otpVerification";
  static const String newPassword  = "/newPassword";


  static Map<String, Widget Function(BuildContext)> routes = {
     splash: (context) => SplashScreen(),
     login: (context) => LoginScreen(),
     register: (context) => RegisterScreen(),
     verifyEmail: (context) => VerifyEmailScreen(),
     forgotPassword: (context) => ForgotPasswordScreen(),
     otpVerification: (context) => OtpVerificationScreen(),
     newPassword: (context) => NewPasswordScreen(),
  };
}