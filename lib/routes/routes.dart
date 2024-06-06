import 'package:clear_home/screens/home_nav/family_member_module/add_members_screen.dart';
import 'package:clear_home/screens/dashboard_screen.dart';
import 'package:clear_home/screens/auth_module/forgot_password_screen.dart';
import 'package:clear_home/screens/auth_module/login_screen.dart';
import 'package:clear_home/screens/auth_module/new_password_screen.dart';
import 'package:clear_home/screens/auth_module/otp_verification_screen.dart';
import 'package:clear_home/screens/auth_module/register_screen.dart';
import 'package:clear_home/screens/home_nav/family_member_module/family_member_details_screen.dart';
import 'package:clear_home/screens/home_nav/family_member_module/family_member_list_screen.dart';
import 'package:clear_home/screens/meal_module/add_meal_screen.dart';
import 'package:clear_home/screens/meal_module/meal_list_screen.dart';
import 'package:clear_home/screens/splash_screen.dart';
import 'package:clear_home/screens/auth_module/verify_email_screen.dart';
import 'package:clear_home/screens/travel_checklist/add_travel_checklist_screen.dart';
import 'package:clear_home/screens/travel_checklist/travel_list_screen.dart';
import 'package:flutter/material.dart';

import '../screens/chat_module/chat_details_screen.dart';
import '../screens/task_module/create_general_task.dart';
import '../screens/task_module/task_details_screen.dart';
import '../screens/task_module/task_list_screen.dart';

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
  static const String  mealList = "/mealList";
  static const String  addMeal = "/addMeal";

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    verifyEmail: (context) => const VerifyEmailScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    otpVerification: (context) => OtpVerificationScreen(),
    newPassword: (context) => const NewPasswordScreen(),
    dashboard: (context) => const DashboardScreen(),
    addMembers: (context) => const AddMembersScreen(),
    familyMemberList: (context) => const FamilyMemberListScreen(),
    familyMemberDetails: (context) => const FamilyMemberDetailsScreen(),
    taskList: (context) => TaskListScreen(),
    createGeneralTask: (context) => const CreateGeneralTask(),
    taskDetails: (context) => const TaskDetailsScreen(),
    chatDetails: (context) => const ChatDetailsScreen(),
    travelList: (context) => TravelListScreen(),
    addTravelList: (context) => const AddTravelChecklistScreen(),
    mealList: (context) => MealListScreen(),
    addMeal: (context) => const AddMealScreen(),
  };
}
