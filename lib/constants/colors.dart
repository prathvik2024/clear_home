import 'package:flutter/material.dart';

class AppColors{
  static const kDarkBlue = Color(0xff1252EA);
  static const kLightBlue = Color(0xff1565EC);
  static const kLiteBlue = Color(0xff1EA6F5);
  static const kHomeBg = Color(0xffEDF8FE);
  static const kDrawerTopBg = Color(0xff34AFF6);
  static const kLightBlueCard = Color(0xff5B9AF4);
  static const kLightOrangeCard = Color(0xffFD7C5A);
  static const kYellow = Color(0xffF8AC59);
  static const kLightBlack = Color(0xff344054);
  static const kGradientSplash = LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight, colors: [kLiteBlue,kDarkBlue]);
  static const kGradientSmall = LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight, colors: [kLiteBlue,kDarkBlue]);
}