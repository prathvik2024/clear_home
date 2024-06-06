import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../models/chat_model.dart';
import '../models/drawer_model.dart';
import '../models/family_card_model.dart';
import '../models/family_member_model.dart';
import '../models/meal_task_model.dart';
import '../models/message_model.dart';
import '../models/recent_task_model.dart';
import '../models/task_item_model.dart';
import 'helper.dart';

class DataProvider {
  static List<Map<String, dynamic>> bottomMenuList = [
    {"icon": AppStrings.svgHome, "title": AppStrings.homeStr},
    {"icon": AppStrings.svgTaskList, "title": AppStrings.taskStr},
    {"icon": AppStrings.svgCalendar, "title": AppStrings.calendarStr},
    {"icon": AppStrings.svgChat, "title": AppStrings.chatStr},
  ];

  static List<DrawerModel> drawerList = [
    DrawerModel(
      title: AppStrings.homeStr,
      icon: AppStrings.svgHome,
    ),
    DrawerModel(title: AppStrings.calendarStr, icon: AppStrings.svgCalendar),
    DrawerModel(title: AppStrings.taskStr, icon: AppStrings.svgTaskList),
    DrawerModel(title: AppStrings.travelCheckListStr, icon: AppStrings.svgTravel),
    DrawerModel(title: AppStrings.categoryStr, icon: AppStrings.svgCategory, child: [
      DrawerModel(title: AppStrings.mealStr, icon: AppStrings.svgDot),
      DrawerModel(title: AppStrings.groceryStr, icon: AppStrings.svgDot),
      DrawerModel(title: AppStrings.medicalStr, icon: AppStrings.svgDot)
    ]),
    DrawerModel(title: AppStrings.digitalAddressBookStr, icon: AppStrings.svgDigitalAddressBook),
    DrawerModel(title: AppStrings.settingsStr, icon: AppStrings.svgSettings, child: [
      DrawerModel(title: AppStrings.profileStr, icon: AppStrings.svgDot),
      DrawerModel(title: AppStrings.resetPasswordStr, icon: AppStrings.svgDot)
    ]),
    DrawerModel(title: AppStrings.logoutStr, icon: AppStrings.svgLogout)
  ];

  static List<MessageModel> messageModel = [
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel("Hii My name is prathvik", "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("what are you doing?", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel("Hii My name is prathvik", "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("what are you doing?", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
  ];

  static List<ChatModel> chatList = [
    ChatModel(
        image: "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg",
        personName: "John Snow",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 10,
        time: "2 hr"),
    ChatModel(
        image:
            "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
        personName: "Vidhi Patel"),
    ChatModel(
        image:
            "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
        personName: "Petter Miller",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 3,
        time: "5 hr"),
    ChatModel(
        image: "https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg",
        personName: "Arya Snow",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 1,
        time: "3 hr ")
  ];

  static List<String> daysName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  static List<String> assigneeList = ["Family Member 1", "Family Member 2", "Family Member 3", "Family Member 4"];
  static List<MealTaskModel> mealTaskList = [
    MealTaskModel(
        TextEditingController(),
        TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
        TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
        TextEditingController(),
        MultiSelectController(),
        false,
        null)
  ];

  static List<String> mealList = [
    "Paneer tika",
    "Manchuriyan",
    "Kaju Masala",
    "Pizza",
    "Burger",
    "Cold Drinks",
    "Paneer tika",
    "Manchuriyan",
    "Kaju Masala",
    "Pizza",
    "Burger",
    "Cold Drinks"
  ];

  static Map<TaskType, String> dynamicAppBarMap = {
    TaskType.TodayTask: AppStrings.todayTaskDetailsStr,
    TaskType.UpcomingTask: AppStrings.upcomingTaskDetailsStr,
    TaskType.PastTask: AppStrings.pastTaskDetailsStr
  };

  static List<String> taskStatusList = [AppStrings.pendingStr, AppStrings.inProgressStr, AppStrings.completedStr];

  static List<TaskItemModel> itemList = [
    TaskItemModel("Passport", true),
    TaskItemModel("Clothes", false),
    TaskItemModel("Camera", true),
    TaskItemModel("Shoes", true),
  ];

  static List<String> travelList = [
    "Italy",
    "America",
    "Kerla",
    "Bali",
    "Maharashtra",
    "Mumbai",
    "Italy",
    "America",
    "Kerla",
    "Bali",
    "Maharashtra",
    "Mumbai"
  ];

  static List<FamilyCardModel> familyCardList = [
    FamilyCardModel("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg", "John Snow", "Father", "Family Owner",
        "07", Helper.colorGenerator()),
    FamilyCardModel(
        "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
        "Vidhi Patel",
        "Mother",
        "Family Member",
        "04",
        Helper.colorGenerator()),
    FamilyCardModel(
        "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
        "Piter Miller",
        "Son",
        "Family Member",
        "04",
        Helper.colorGenerator()),
    FamilyCardModel("https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg", "Arya Snow", "Daughter",
        "Family Member", "05", Helper.colorGenerator()),
  ];

  static List<String> userInfo = ["David Smith", "Family Owner", "1234567890", "davidsmith@gmail.com"];
  static List<String> columnList = [AppStrings.memberNameTagStr, AppStrings.relationTagStr, AppStrings.mobileTagStr, AppStrings.emailTagStr];

  static List<FamilyMemberModel> familyMemberList = [
    FamilyMemberModel("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg", "John Snow"),
    FamilyMemberModel(
        "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
        "Vidhi Patel"),
    FamilyMemberModel(
        "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
        "Petter Miller"),
    FamilyMemberModel("https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg", "Arya Snow"),
  ];

  static  List<RecentTaskModel> recentTaskList = [
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
    RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"),
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
    RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"),
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
    RecentTaskModel(AppStrings.svgTravel, "Travel Checklist", "21-03-2022", "David"),
    RecentTaskModel(AppStrings.svgShoppingBasket, "Buy Groceries", "21-03-2022", "Angelina"),
    RecentTaskModel(AppStrings.svgLunch, "Prepare Lunch", "21-03-2022", "Liza"),
  ];
}
