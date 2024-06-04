import 'package:clear_home/screens/chat_nav/chat_details_screen.dart';
import 'package:clear_home/screens/home_nav/add_members_screen.dart';
import 'package:clear_home/screens/dashboard_screen.dart';
import 'package:clear_home/screens/auth_module/forgot_password_screen.dart';
import 'package:clear_home/screens/auth_module/login_screen.dart';
import 'package:clear_home/screens/auth_module/new_password_screen.dart';
import 'package:clear_home/screens/auth_module/otp_verification_screen.dart';
import 'package:clear_home/screens/auth_module/register_screen.dart';
import 'package:clear_home/screens/home_nav/family_member_details_screen.dart';
import 'package:clear_home/screens/home_nav/family_member_list_screen.dart';
import 'package:clear_home/screens/splash_screen.dart';
import 'package:clear_home/screens/auth_module/verify_email_screen.dart';
import 'package:clear_home/screens/task_nav/create_general_task.dart';
import 'package:clear_home/screens/task_nav/task_details_screen.dart';
import 'package:clear_home/screens/travel_checklist/add_travel_checklist_screen.dart';
import 'package:clear_home/screens/travel_checklist/travel_list_screen.dart';
import 'package:flutter/material.dart';

import '../screens/task_nav/task_list_screen.dart';

class AppRoutes {
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String verifyEmail = "/verifyEmail";
  static const String forgotPassword = "/forgotPassword";
  static const String otpVerification = "/otpVerification";
  static const String newPassword = "/newPassword";
  static const String dashboard = "/dashboard";
  static const String addMembers = "/addMembers";
  static const String familyMemberList = "/familyMemberList";
  static const String familyMemberDetails = "/familyMemberDetails";
  static const String taskList = "/taskList";
  static const String createGeneralTask = "/createGeneralTask";
  static const String taskDetails = "/taskDetails";
  static const String chatDetails = "/chatDetails";
  static const String  travelList = "/travelList";
  static const String  addTravelList = "/addTravelChecklist";

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
    taskList: (context) => TaskListScreen(),
    createGeneralTask: (context) => CreateGeneralTask(),
    taskDetails: (context) => TaskDetailsScreen(),
    chatDetails: (context) => ChatDetailsScreen(),
    travelList: (context) => TravelListScreen(),
    addTravelList: (context) => AddTravelChecklistScreen(),
  };
}
