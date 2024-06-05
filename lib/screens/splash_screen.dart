import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, AppRoutes.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(gradient: AppColors.kGradientSplash),
        child: Center(
          child: SvgPicture.asset(AppStrings.svgIconLogo),
        ),
      ),
    );
  }
}
