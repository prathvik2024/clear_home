import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/family_member_profile_screen.dart';
import 'package:clear_home/screens/family_member_task_screen.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FamilyMemberDetailsScreen extends StatefulWidget {
  const FamilyMemberDetailsScreen({super.key});

  @override
  State<FamilyMemberDetailsScreen> createState() => _FamilyMemberDetailsScreenState();
}

class _FamilyMemberDetailsScreenState extends State<FamilyMemberDetailsScreen> {
  int selectedTabIndex = 0;
  Map<String, String>? args;
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    _pageController = PageController(
      initialPage: selectedTabIndex,
    );
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.familyMemberDetailStr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        selectedTabIndex = 0;
                        _pageController?.jumpToPage(0);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: (selectedTabIndex == 0)
                            ? BoxDecoration(
                                color: AppColors.kLiteBlue,
                                boxShadow: [BoxShadow(color: AppColors.kLiteBlue.withOpacity(0.3), spreadRadius: 1, blurRadius: 2)],
                                borderRadius: BorderRadius.circular(40))
                            : null,
                        child: Text(
                          AppStrings.profileStr,
                          textAlign: TextAlign.center,
                          style: (selectedTabIndex == 0)
                              ? AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white)
                              : AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        selectedTabIndex = 1;
                        _pageController?.jumpToPage(1);
                        setState(() {});
                      },
                      child: Container(
                        decoration: (selectedTabIndex == 1)
                            ? BoxDecoration(
                                color: AppColors.kLiteBlue,
                                boxShadow: [BoxShadow(color: AppColors.kLiteBlue.withOpacity(0.3), spreadRadius: 1, blurRadius: 2)],
                                borderRadius: BorderRadius.circular(40))
                            : null,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          AppStrings.taskStr,
                          textAlign: TextAlign.center,
                          style: (selectedTabIndex == 1)
                              ? AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white)
                              : AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
                child: PageView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (num) {
                selectedTabIndex = num;
                setState(() {});
              },
              children: [
                FamilyMemberProfileScreen(
                  args: args,
                ),
                FamilyMemberTaskScreen()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
