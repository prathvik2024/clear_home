import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../constants/data_provider.dart';
import '../../../models/recent_task_model.dart';
import '../../../widgets/home_widgets/recent_list_card_view.dart';

class FamilyMemberTaskScreen extends StatefulWidget {
  const FamilyMemberTaskScreen({super.key});

  @override
  State<FamilyMemberTaskScreen> createState() => _FamilyMemberTaskScreenState();
}

class _FamilyMemberTaskScreenState extends State<FamilyMemberTaskScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: const Size(double.minPositive, 30)),
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Text(
                    AppStrings.todayStr,
                    style: (selectedIndex == 0)
                        ? AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue)
                        : AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Colors.black.withOpacity(
                    0.08,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: const Size(double.minPositive, 30)),
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
                const SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Colors.black.withOpacity(
                    0.08,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: const Size(double.minPositive, 30)),
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
        Expanded(
          child: Container(
            child: () {
              if (selectedIndex == 1) {
                return upcomingTask();
              } else if (selectedIndex == 2) {
                return pastTask();
              } else {
                return todayTask();
              }
            }(),
          ),
        )
        //   ),
        // )
      ],
    );
  }

  Widget todayTask() {
    return RecentListCardView(
      recentTaskList: DataProvider.recentTaskList,
      taskType: TaskType.TodayTask,
    );
  }

  Widget upcomingTask() {
    DataProvider.recentTaskList = [...DataProvider.recentTaskList.reversed];
    return RecentListCardView(
      recentTaskList: DataProvider.recentTaskList,
      taskType: TaskType.UpcomingTask,
    );
  }

  Widget pastTask() {
    DataProvider.recentTaskList = [...DataProvider.recentTaskList.reversed];
    return RecentListCardView(
      recentTaskList: DataProvider.recentTaskList,
      taskType: TaskType.PastTask,
    );
  }
}
