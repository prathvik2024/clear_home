import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/screens/bottom_nav/calendar_screen.dart';
import 'package:clear_home/screens/bottom_nav/chat_screen.dart';
import 'package:clear_home/screens/bottom_nav/task_list_screen.dart';
import 'bottom_nav/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> bottomMenuList = [];
  int selectedPage = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Builder(
            builder: (context) {
              switch(selectedPage){
                case 0: return HomeScreen();
                case 1: return TaskListScreen();
                case 2: return CalendarScreen();
                case 3: return ChatScreen();
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kDarkBlue,
        child: Icon(Icons.add, color: Colors.white,size: 34,),
        onPressed: () {},
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
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
