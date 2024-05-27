import 'package:clear_home/screens/login_screen.dart';
import 'package:clear_home/screens/register_screen.dart';
import 'package:clear_home/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String splash  = "/";
  static const String login  = "/login";
  static const String register  = "/register";
  static const String verifyEmail  = "/verifyEmail";


  static Map<String, Widget Function(BuildContext)> routes = {
     splash: (context) => SplashScreen(),
     login: (context) => LoginScreen(),
     register: (context) => RegisterScreen(),
     verifyEmail: (context) => RegisterScreen(),
  };
}