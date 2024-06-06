import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/home_nav/family_member_module/family_member_profile_screen.dart';
import 'package:clear_home/screens/home_nav/family_member_module/family_member_task_screen.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_tabview.dart';
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
            const SizedBox(
              height: 20,
            ),
            CustomTabview(
                tabController: _tabController,
                tabChange: (index) {
                  selectedTabIndex = index;
                  _pageController!.jumpToPage(index);
                }),
            Expanded(
                child: PageView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (tab) {
                selectedTabIndex = tab;
                _tabController.index = tab;
                setState(() {});
              },
              children: [
                FamilyMemberProfileScreen(
                  args: args,
                ),
                const FamilyMemberTaskScreen()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
