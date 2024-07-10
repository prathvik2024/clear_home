import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        SharedPreferences spf = await SharedPreferences.getInstance();
        if (spf.getString("userName") != null) {

          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.kGradientSplash),
        child: Center(
          child: SvgPicture.asset(AppStrings.svgIconLogo),
        ),
      ),
    );
  }
}
