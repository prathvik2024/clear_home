import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:clear_home/widgets/home_widgets/family_card_view.dart';
import 'package:clear_home/widgets/home_widgets/recent_list_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/strings.dart';

class HomeScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Function(String)? backScreen;

  HomeScreen({super.key, required this.scaffoldKey, required this.backScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 21, right: 21),
        child: Row(
          children: [
            CircularImage(
              imageWidget: Image.asset(
                AppStrings.imgProfile,
                fit: BoxFit.cover,
              ),
              onclick: () {
                widget.scaffoldKey.currentState?.openDrawer();
              },
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: AppColors.kDarkBlue,
                  size: 28,
                )),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppStrings.svgNotification,
                  width: 28,
                  height: 28,
                )),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  AppStrings.familyMembersStr,
                  style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: size.height * 0.26,
                  child: FamilyCardView(
                    familyCardList: DataProvider.familyCardList,
                  )),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.recentTaskStr,
                      style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          widget.backScreen?.call(AppStrings.taskStr);
                        },
                        child: Text(
                          AppStrings.seeAllStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: RecentListCardView(
                  recentTaskList: DataProvider.recentTaskList,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  taskType: TaskType.TodayTask,
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
