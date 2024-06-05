import 'package:clear_home/models/drawer_model.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/screens/meal_module/meal_list_screen.dart';
import 'package:clear_home/screens/task_module/task_list_screen.dart';
import 'package:clear_home/screens/travel_checklist/travel_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/calendar_screen.dart';
import '../constants/fonts.dart';
import '../widgets/custom_dialog.dart';
import 'chat_module/chat_list_screen.dart';
import 'home_nav/home_screen.dart';

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

    drawerList.add(DrawerModel(
        title: "Home",
        icon: AppStrings.svgHome,
        onClick: () {
          _scaffoldKey.currentState!.closeDrawer();
          setState(() {});
        }));
    drawerList.add(DrawerModel(
        title: "Calendar",
        icon: AppStrings.svgCalendar,
        onClick: () {
          _scaffoldKey.currentState!.closeDrawer();
          selectedPage = 2;
          setState(() {});
        }));
    drawerList.add(DrawerModel(
        title: "Task",
        icon: AppStrings.svgTaskList,
        onClick: () {
          _scaffoldKey.currentState!.closeDrawer();
          selectedPage = 1;
          setState(() {});
        }));
    drawerList.add(DrawerModel(
        title: "Travel Checklist",
        icon: AppStrings.svgTravel,
        onClick: () {
          _scaffoldKey.currentState!.closeDrawer();
          selectedPage = 4;
          setState(() {});
        }));
    drawerList.add(DrawerModel(title: "Category", icon: AppStrings.svgCategory, child: [
      DrawerModel(
          title: "Meal",
          icon: AppStrings.svgDot,
          onClick: () {
            _scaffoldKey.currentState!.closeDrawer();
            selectedPage = 5;
            setState(() {});
          }),
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              title: AppStrings.exitAppStr,
              negativeOnclick: () => Navigator.pop(context),
              positiveOnclick: () => SystemNavigator.pop(),
              negativeButtonName: AppStrings.noButtonStr,
              positiveButtonName: AppStrings.yesButtonStr,
            );
          },
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          width: width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.25,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.only(left: 25, right: 10, bottom: 0, top: 30),
                color: AppColors.kDrawerTopBg,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.closeDrawer();
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: drawerList[index].onClick,
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
                                          onTap: drawerList[index].child?[i].onClick,
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          visualDensity: VisualDensity(vertical: -4),
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
        ),
        backgroundColor: AppColors.kHomeBg,
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            child: Builder(
              builder: (context) {
                switch (selectedPage) {
                  case 0:
                    return HomeScreen(
                      scaffoldKey: _scaffoldKey,
                        backScreen: (int index) {
                          selectedPage = index;
                          setState(() {});
                        }
                    );
                  case 1:
                    return TaskListScreen(
                      backScreen: (int index) {
                        selectedPage = index;
                        setState(() {});
                      },
                    );
                  case 2:
                    return CalendarScreen();
                  case 3:
                    return ChatListScreen(
                      backScreen: (int index) {
                        selectedPage = index;
                        setState(() {});
                      },
                    );
                  case 4:
                    return TravelListScreen(
                      backScreen: (int index) {
                        selectedPage = 0;
                        setState(() {});
                      },
                    );
                  case 5:
                    return MealListScreen(
                      backScreen: (int index) {
                        selectedPage = 0;
                        setState(() {});
                      },
                    );
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
            onPressed: () {
              switch (selectedPage) {
                case 0:
                  Navigator.pushNamed(context, AppRoutes.addMembers);
                case 1:
                  Navigator.pushNamed(context, AppRoutes.createGeneralTask);
                case 2:
                  Navigator.pushNamed(context, AppRoutes.addMembers);
                case 3:
                  Navigator.pushNamed(context, AppRoutes.addMembers);
                case 4:
                  Navigator.pushNamed(context, AppRoutes.addTravelList);
                case 5:
                  Navigator.pushNamed(context, AppRoutes.addMeal);
              }
            },
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
      ),
    );
  }
}
