import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';

import '../models/recent_task_model.dart';
import '../widgets/home_widgets/recent_list_card_view.dart';

class FamilyMemberTaskScreen extends StatefulWidget {
  FamilyMemberTaskScreen({super.key});

  @override
  State<FamilyMemberTaskScreen> createState() => _FamilyMemberTaskScreenState();
}

class _FamilyMemberTaskScreenState extends State<FamilyMemberTaskScreen> {
  int selectedIndex = 0;
  List<RecentTaskModel> recentTaskList = [];

  @override
  void initState() {
    super.initState();
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"));
    recentTaskList.add(RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: Size(double.minPositive, 30)),
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Text(
                    AppStrings.todayStr,
                    style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: (selectedIndex == 0) ? AppColors.kDarkBlue : Colors.black),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Colors.black.withOpacity(
                    0.08,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: Size(double.minPositive, 30)),
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  child: Text(
                    AppStrings.upcommingStr,
                    style: (selectedIndex == 1)
                        ? AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue)
                        : AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Colors.black.withOpacity(
                    0.08,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: Size(double.minPositive, 30)),
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  child: Text(
                    AppStrings.pastStr,
                    style: (selectedIndex == 2)
                        ? AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue)
                        : AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: Container(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         if (selectedIndex == 0) ...[TodayTask()],
        //         if (selectedIndex == 1) ...[UpcomingTask()],
        //         if (selectedIndex == 2) ...[PastTask()]
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget TodayTask() {
    return RecentListCardView(recentTaskList: recentTaskList);
  }

  Widget UpcomingTask() {
    return RecentListCardView(recentTaskList: recentTaskList);
  }

  Widget PastTask() {
    return RecentListCardView(recentTaskList: recentTaskList);
  }
}
