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

class _FamilyMemberDetailsScreenState extends State<FamilyMemberDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int selectedTabIndex = 0;
  Map<String, String>? args;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                child: TabBar(
                  padding: EdgeInsets.zero,
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      child: Container(
                        width: width * 50,
                        child: Text(
                              AppStrings.profileStr,
                              textAlign: TextAlign.center,),
                      )
                    ),
                    Tab(
                      child:  Container(
                        width: width * 50,
                        child: Text(
                          AppStrings.taskStr,
                          textAlign: TextAlign.center,),
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
                  onTap: (index){
                    selectedTabIndex = index;
                    _pageController?.jumpToPage(index);
                  },
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
                _tabController.index = num;
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
