import 'dart:math' as math;

import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:clear_home/widgets/home_widgets/family_card_view.dart';
import 'package:clear_home/widgets/home_widgets/recent_list_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/strings.dart';
import '../../models/family_card_model.dart';
import '../../models/recent_task_model.dart';

class HomeScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Function(int)? backScreen;

  HomeScreen({super.key, required this.scaffoldKey, required this.backScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color colorGenerator() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);
  }

  List<FamilyCardModel> familyCardList = [];
  List<RecentTaskModel> recentTaskList = [];

  @override
  void initState() {
    super.initState();
    familyCardList.add(
      FamilyCardModel("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg", "John Snow", "Father",
          "Family Owner", "07", colorGenerator()),
    );
    familyCardList.add(
      FamilyCardModel(
          "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
          "Vidhi Patel",
          "Mother",
          "Family Member",
          "04",
          colorGenerator()),
    );
    familyCardList.add(
      FamilyCardModel(
          "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
          "Piter Miller",
          "Son",
          "Family Member",
          "04",
          colorGenerator()),
    );
    familyCardList.add(
      FamilyCardModel("https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg", "Arya Snow", "Daughter",
          "Family Member", "05", colorGenerator()),
    );
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
                Scaffold.of(context).openDrawer();
                widget.scaffoldKey.currentState!.openDrawer();
              },
            ),
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
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
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: height * 0.73,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  AppStrings.familyMembersStr,
                  style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                  height: height * 0.26,
                  child: FamilyCardView(
                    familyCardList: familyCardList,
                  )),
              SizedBox(
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
                          widget.backScreen?.call(1);
                        },
                        child: Text(
                          AppStrings.seeAllStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: RecentListCardView(
                  recentTaskList: recentTaskList,
                  physics: NeverScrollableScrollPhysics(),
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
