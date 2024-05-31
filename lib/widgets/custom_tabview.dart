import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/strings.dart';

class CustomTabview extends StatelessWidget {
  TabController tabController;
  Function(int index) tabChange;

  CustomTabview({super.key, required this.tabController, required this.tabChange});

  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6.0),
        child: TabBar(
          padding: EdgeInsets.zero,
          controller: tabController,
          labelPadding: EdgeInsets.zero,
          tabs: [
            Tab(
                child: Container(
              width: width * 50,
              child: Text(
                AppStrings.profileStr,
                textAlign: TextAlign.center,
              ),
            )),
            Tab(
              child: Container(
                width: width * 50,
                child: Text(
                  AppStrings.taskStr,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          physics: BouncingScrollPhysics(),
          dividerHeight: 0,
          labelStyle: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
          unselectedLabelStyle: AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
          indicator: BoxDecoration(
              color: AppColors.kLiteBlue,
              boxShadow: [BoxShadow(color: AppColors.kLiteBlue.withOpacity(0.3), spreadRadius: 1, blurRadius: 2)],
              borderRadius: BorderRadius.circular(40)),
          onTap: (index) {
            selectedTabIndex = index;
            tabChange(index);
          },
        ),
      ),
    );
  }
}
