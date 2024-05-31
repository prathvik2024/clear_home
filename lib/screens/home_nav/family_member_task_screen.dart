import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../models/recent_task_model.dart';
import '../../widgets/home_widgets/recent_list_card_view.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                      padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: Size(double.minPositive, 30)),
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
        Expanded(
          child: Container(
            child: () {
              if (selectedIndex == 1) {
                return UpcomingTask();
              } else if (selectedIndex == 2) {
                return PastTask();
              } else {
                return TodayTask();
              }
            }(),
          ),
        )
        //   ),
        // )
      ],
    );
  }

  Widget TodayTask() {
    return RecentListCardView(recentTaskList: recentTaskList);
  }

  Widget UpcomingTask() {
    recentTaskList = [...recentTaskList.reversed];
    return RecentListCardView(recentTaskList: recentTaskList);
  }

  Widget PastTask() {
    recentTaskList = [...recentTaskList.reversed];
    return RecentListCardView(recentTaskList: recentTaskList);
  }
}
