import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/screens/meal_module/meal_list_screen.dart';
import 'package:clear_home/screens/task_module/task_list_screen.dart';
import 'package:clear_home/screens/travel_checklist/travel_list_screen.dart';
import 'package:clear_home/widgets/home_widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/calendar_screen.dart';
import '../widgets/custom_dialog.dart';
import 'chat_module/chat_list_screen.dart';
import 'home_nav/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isCategoryOpen = false, isSettingsOpen = false;
  String selectedPage = AppStrings.homeStr;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void doubleClickCloseApp(didPop) {
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
  }

  void fabClickRedirectPage() {
    switch (selectedPage) {
      case AppStrings.homeStr:
        Navigator.pushNamed(context, AppRoutes.addMembers);
      case AppStrings.taskStr:
        Navigator.pushNamed(context, AppRoutes.createGeneralTask);
      case AppStrings.calendarStr:
        Navigator.pushNamed(context, AppRoutes.addMembers);
      case AppStrings.chatStr:
        Navigator.pushNamed(context, AppRoutes.addMembers);
      case AppStrings.travelCheckListStr:
        Navigator.pushNamed(context, AppRoutes.addTravelList, arguments: {"": null});
      case AppStrings.mealStr:
        Navigator.pushNamed(context, AppRoutes.addMeal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: doubleClickCloseApp,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(
          onChange: (value) {
            if (value != null) {
              selectedPage = value;
            }
            setState(() {});
          },
          scaffoldKey: _scaffoldKey,
        ),
        backgroundColor: AppColors.kHomeBg,
        body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
            SizedBox(
              child: Builder(
                builder: (context) {
                  switch (selectedPage) {
                    case AppStrings.homeStr:
                      return HomeScreen(
                          scaffoldKey: _scaffoldKey,
                          backScreen: (String route) {
                            selectedPage = route;
                            setState(() {});
                          });
                    case AppStrings.taskStr:
                      return TaskListScreen(
                        backScreen: (String route) {
                          selectedPage = route;
                          setState(() {});
                        },
                      );
                    case AppStrings.calendarStr:
                      return const CalendarScreen();
                    case AppStrings.chatStr:
                      return ChatListScreen(
                        backScreen: (String route) {
                          selectedPage = route;
                          setState(() {});
                        },
                      );
                    case AppStrings.travelCheckListStr:
                      return TravelListScreen(
                        backScreen: (String route) {
                          selectedPage = route;
                          setState(() {});
                        },
                      );
                    case AppStrings.mealStr:
                      return MealListScreen(
                        backScreen: (String route) {
                          selectedPage = route;
                          setState(() {});
                        },
                      );
                    default:
                      return HomeScreen(
                          scaffoldKey: _scaffoldKey,
                          backScreen: (String route) {
                            selectedPage = route;
                            setState(() {});
                          });
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.only(left: 21, right: 21, bottom: 25),
                height: 70,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: DataProvider.bottomMenuList.map((item) {
                        return IconButton(
                            onPressed: () {
                              selectedPage = item["title"];
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              item["icon"],
                              width: 28,
                              height: 28,
                              color: ((selectedPage == item["title"]) ? AppColors.kDarkBlue : Colors.grey),
                            ),
                            style: (selectedPage == item["title"])
                                ? IconButton.styleFrom(
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: const BorderSide(
                                        color: AppColors.kHomeBg,
                                        width: 4,
                                      ),
                                    ))
                                : null);
                      }).toList()),
                ),
              ),
            ),
            Positioned(
              bottom:100,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: FloatingActionButton(
                  backgroundColor: AppColors.kDarkBlue,
                  onPressed: fabClickRedirectPage,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
