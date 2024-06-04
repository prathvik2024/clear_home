import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';
import '../../constants/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/show_toast.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  String? startDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now());
  String? startTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
      endTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now());
  TextEditingController mealDateController = TextEditingController();
  TextEditingController mealTitleController = TextEditingController();
  TextEditingController mealStartTimeController = TextEditingController();
  TextEditingController mealEndTimeController = TextEditingController();

  List<String> daysName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.addMealStr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.mealDateStr,
                  style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: width * 0.4,
                  child: CustomTextField(
                    enabled: false,
                    onClick: () async {
                      startDate = await selectDate();
                      setState(() {});
                    },
                    controller: mealDateController,
                    hintText: startDate,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                      child: SvgPicture.asset(
                        AppStrings.svgCalendar,
                        width: 24,
                        height: 24,
                        color: AppColors.kDarkBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.kDarkBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  daysName.length,
                  (index) {
                    return TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          minimumSize: Size.zero),
                      onPressed: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: Text(
                        daysName[index],
                        style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: (selectedIndex == index) ? AppColors.kDarkBlue : Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CustomTextField(
              controller: mealTitleController,
              textLabel: AppStrings.mealTitleStr,
              validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isAlpha, errorMsg: AppStrings.nameError),
              hintText: AppStrings.hintName,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              AppStrings.timeStr,
              style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.startStr,
                        style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        enabled: false,
                        onClick: () async {
                          startTime = await selectDate();
                          setState(() {});
                        },
                        controller: mealStartTimeController,
                        hintText: startTime,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                          child: SvgPicture.asset(
                            AppStrings.svgClock,
                            width: 24,
                            height: 24,
                            color: AppColors.kDarkBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.endStr,
                        style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        enabled: false,
                        onClick: () async {
                          endTime = await selectDate();
                          setState(() {});
                        },
                        contentPadding: EdgeInsets.zero,
                        controller: mealEndTimeController,
                        hintText: endTime,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                          child: SvgPicture.asset(
                            AppStrings.svgCalendar,
                            width: 24,
                            height: 24,
                            color: AppColors.kDarkBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> selectTime() async {
    final TimeOfDay? pickTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickTime != null) {
      return DateFormat(AppStrings.timeFormatStr)
          .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, pickTime.hour, pickTime.minute));
    } else {
      ShowToast(msg: "Something went wrong!");
      return null;
    }
  }

  Future<String?> selectDate() async {
    final DateTime? pickDate =
        await showDatePicker(context: context, firstDate: DateTime.now(), initialDate: DateTime.now(), lastDate: DateTime(2025));
    if (pickDate != null) {
      return DateFormat(AppStrings.dateFormatStr).format(pickDate);
    } else {
      ShowToast(msg: "Something went wrong!");
      return null;
    }
  }
}
