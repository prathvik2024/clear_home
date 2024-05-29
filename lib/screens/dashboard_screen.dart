import 'dart:developer';

import 'package:clear_home/models/drawer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/bottom_nav/calendar_screen.dart';
import 'package:clear_home/screens/bottom_nav/chat_screen.dart';
import 'package:clear_home/screens/bottom_nav/task_list_screen.dart';
import '../constants/fonts.dart';
import 'bottom_nav/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> bottomMenuList = [];
  List<DrawerModel> drawerList = [];
  bool isCategoryOpen = false, isSettingsOpen = false;

  int selectedPage = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bottomMenuList.add({
      "icon": AppStrings.svgHome,
      "onclick": () {
        selectedPage = 0;
        setState(() {});
      }
    });
    bottomMenuList.add({
      "icon": AppStrings.svgTaskList,
      "onclick": () {
        selectedPage = 1;
        setState(() {});
      }
    });
    bottomMenuList.add({
      "icon": AppStrings.svgCalendar,
      "onclick": () {
        selectedPage = 2;
        setState(() {});
      }
    });
    bottomMenuList.add(
      {
        "icon": AppStrings.svgChat,
        "onclick": () {
          selectedPage = 3;
          setState(() {});
        }
      },
    );

    drawerList.add(DrawerModel(title: "Home", icon: AppStrings.svgHome));
    drawerList.add(DrawerModel(title: "Calendar", icon: AppStrings.svgCalendar));
    drawerList.add(DrawerModel(title: "Task", icon: AppStrings.svgTaskList));
    drawerList.add(DrawerModel(title: "Travel Checklist", icon: AppStrings.svgTravel));
    drawerList.add(DrawerModel(title: "Category", icon: AppStrings.svgCategory, child: [
      DrawerModel(title: "Meal", icon: AppStrings.svgDot),
      DrawerModel(title: "Grocery", icon: AppStrings.svgDot),
      DrawerModel(title: "Medical", icon: AppStrings.svgDot)
    ]));
    drawerList.add(DrawerModel(title: "Digital Address Book", icon: AppStrings.svgDigitalAddressBook));
    drawerList.add(DrawerModel(
        title: "Settings",
        icon: AppStrings.svgSettings,
        child: [DrawerModel(title: "Profile", icon: AppStrings.svgDot), DrawerModel(title: "Reset Password", icon: AppStrings.svgDot)]));
    drawerList.add(DrawerModel(title: "Logout", icon: AppStrings.svgLogout));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
          child: Drawer(
        width: width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height * 0.20,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(left: 25, right: 10, bottom: 0),
              color: AppColors.kDrawerTopBg,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.white,
                        )),
                  ),
                  Row(
                    children: [
                      Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 4)]),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  child: Image.asset(
                                    AppStrings.imgProfile,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.kDarkBlue,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "David Smith",
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "davidsmith@gmail.com",
                            style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.15),
              height: 0.3,
            ),
            Expanded(
              child: Container(
                width: width,
                color: AppColors.kLiteBlue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: SvgPicture.asset(
                              drawerList[index].icon,
                              color: Colors.white,
                            ),
                            title: Text(
                              drawerList[index].title,
                              style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.white),
                            ),
                            trailing: (drawerList[index].child != null)
                                ? IconButton(
                                    onPressed: () {
                                      drawerList[index].isExpanded = !drawerList[index].isExpanded;
                                      setState(() {});
                                    },
                                    icon: SvgPicture.asset((drawerList[index].isExpanded ? AppStrings.svgUpArrow : AppStrings.svgDownArrow)))
                                : null,
                            contentPadding: EdgeInsets.all(0),
                          ),
                          Visibility(
                              visible: drawerList[index].isExpanded,
                              child: Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Column(
                                  children: List.generate(
                                    drawerList[index].child?.length ?? 0,
                                    (i) {
                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        visualDensity: VisualDensity(vertical: -4) ,
                                        leading: SvgPicture.asset(drawerList[index].child?[i].icon ?? ""),
                                        title: Text(
                                          drawerList[index].child?[i].title ?? "",
                                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ))
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.15),
                        ),
                    itemCount: drawerList.length),
              ),
            )
          ],
        ),
      )),
      backgroundColor: AppColors.kHomeBg,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: Builder(
            builder: (context) {
              switch (selectedPage) {
                case 0:
                  return HomeScreen();
                case 1:
                  return TaskListScreen();
                case 2:
                  return CalendarScreen();
                case 3:
                  return ChatScreen();
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.kDarkBlue,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 34,
          ),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        margin: EdgeInsets.only(left: 21, right: 21, bottom: 30),
        height: 70,
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomMenuList.map((item) {
                return IconButton(
                    onPressed: item["onclick"],
                    icon: SvgPicture.asset(
                      item["icon"],
                      width: 28,
                      height: 28,
                      color: ((selectedPage == bottomMenuList.indexOf(item)) ? AppColors.kDarkBlue : Colors.grey),
                    ),
                    style: (selectedPage == bottomMenuList.indexOf(item))
                        ? IconButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: AppColors.kHomeBg,
                                width: 4,
                              ),
                            ))
                        : null);
              }).toList()),
        ),
      ),
    );
  }
}
