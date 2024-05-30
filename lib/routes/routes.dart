import 'package:clear_home/screens/add_members_screen.dart';
import 'package:clear_home/screens/dashboard_screen.dart';
import 'package:clear_home/screens/auth_module/forgot_password_screen.dart';
import 'package:clear_home/screens/bottom_nav/home_screen.dart';
import 'package:clear_home/screens/auth_module/login_screen.dart';
import 'package:clear_home/screens/auth_module/new_password_screen.dart';
import 'package:clear_home/screens/auth_module/otp_verification_screen.dart';
import 'package:clear_home/screens/auth_module/register_screen.dart';
import 'package:clear_home/screens/family_member_details_screen.dart';
import 'package:clear_home/screens/family_member_list_screen.dart';
import 'package:clear_home/screens/splash_screen.dart';
import 'package:clear_home/screens/auth_module/verify_email_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  static const String splash  = "/";
  static const String login  = "/login";
  static const String register  = "/register";
  static const String verifyEmail  = "/verifyEmail";
  static const String forgotPassword  = "/forgotPassword";
  static const String otpVerification  = "/otpVerification";
  static const String newPassword  = "/newPassword";
  static const String dashboard  = "/dashboard";
  static const String addMembers  = "/addMembers";
  static const String familyMemberList  = "/familyMemberList";
  static const String familyMemberDetails  = "/familyMemberDetailsScreen";


  static Map<String, Widget Function(BuildContext)> routes = {
     splash: (context) => SplashScreen(),
     login: (context) => LoginScreen(),
     register: (context) => RegisterScreen(),
     verifyEmail: (context) => VerifyEmailScreen(),
     forgotPassword: (context) => ForgotPasswordScreen(),
     otpVerification: (context) => OtpVerificationScreen(),
     newPassword: (context) => NewPasswordScreen(),
    dashboard: (context) => DashboardScreen(),
    addMembers: (context) => AddMembersScreen(),
    familyMemberList: (context) => FamilyMemberListScreen(),
    familyMemberDetails: (context) => FamilyMemberDetailsScreen(),
  };
}