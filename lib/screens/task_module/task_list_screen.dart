import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_tabview.dart';
import 'package:flutter/material.dart';

import '../home_nav/family_member_module/family_member_profile_screen.dart';
import '../home_nav/family_member_module/family_member_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  final Function(String)? backScreen;

  const TaskListScreen({super.key, this.backScreen});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: selectedTabIndex);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.taskListStr,
        backClick: () {
          widget.backScreen?.call(AppStrings.homeStr);
        },
        actionWidgets: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.search_rounded,
                  color: AppColors.kDarkBlue,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTabview(
                tabController: tabController,
                tabChange: (index) {
                  selectedTabIndex = index;
                  _pageController.jumpToPage(index);
                }),
            Expanded(
                child: PageView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (tab) {
                selectedTabIndex = tab;
                tabController.index = tab;
                setState(() {});
              },
              children: const [FamilyMemberProfileScreen(), FamilyMemberTaskScreen()],
            ))
          ],
        ),
      ),
    );
  }
}
