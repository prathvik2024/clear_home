import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';
import '../../constants/validator.dart';
import '../../models/meal_task_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
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

  List<String> daysName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> assigneeList = ["Family Member 1", "Family Member 2", "Family Member 3", "Family Member 4"];
  int selectedIndex = 0;
  List<MealTaskModel> mealTaskList = [
    MealTaskModel(
        TextEditingController(),
        TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
        TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
        TextEditingController(),
        MultiSelectController(),
        false,
        null)
  ];

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
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                style: AppFonts.kPoppinsRegular
                                    .copyWith(fontSize: 14, color: (selectedIndex == index) ? AppColors.kDarkBlue : Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: List.generate(
                        mealTaskList.length,
                        (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                onChange: (input) {
                                  if (Validator.isAlpha(input: input.trim())) {
                                    mealTaskList[index].errorMessage = null;
                                  } else {
                                    mealTaskList[index].errorMessage = AppStrings.nameError;
                                  }
                                  setState(() {});
                                },
                                errorText: mealTaskList[index].errorMessage,
                                controller: mealTaskList[index].mealTitleController,
                                textLabel: AppStrings.mealTitleStr,
                                hintText: AppStrings.hintName,
                              ),
                              SizedBox(
                                height: 20,
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
                                            startTime = await selectTime();
                                            mealTaskList[index].mealStartTimeController.text = startTime ?? "";
                                            setState(() {});
                                          },
                                          controller: mealTaskList[index].mealStartTimeController,
                                          hintText: mealTaskList[index].mealStartTimeController.text,
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
                                            endTime = await selectTime();
                                            mealTaskList[index].mealEndTimeController.text = endTime ?? "";
                                            setState(() {});
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          controller: mealTaskList[index].mealEndTimeController,
                                          hintText: mealTaskList[index].mealEndTimeController.text,
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
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                controller: mealTaskList[index].mealMenuDetailsController,
                                keyboardType: TextInputType.multiline,
                                textLabel: AppStrings.mealDetailsStr,
                                minLines: 4,
                                maxLines: 8,
                                borderRadius: 15,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              MultiSelectDropDown(
                                controller: mealTaskList[index].multiSelectController,
                                inputDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: Colors.black12,
                                    )),
                                hint: AppStrings.assignedToStr,
                                onOptionSelected: (result) {},
                                fieldBackgroundColor: AppColors.kLiteBlue,
                                focusedBorderColor: Colors.transparent,
                                selectedOptionTextColor: AppColors.kLiteBlue,
                                borderColor: Colors.transparent,
                                borderWidth: 0,
                                options: assigneeList.map((item) {
                                  return ValueItem(
                                    label: item,
                                    value: item,
                                  );
                                }).toList(),
                                selectionType: SelectionType.multi,
                                optionTextStyle: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                                chipConfig: ChipConfig(
                                  backgroundColor: AppColors.kLiteBlue,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (mealTaskList[index].isDelete) {
                                    mealTaskList.removeAt(index);
                                  } else {
                                    if (mealTaskList[index].mealTitleController.text.trim().isNotEmpty) {
                                      mealTaskList.add(MealTaskModel(
                                          TextEditingController(),
                                          TextEditingController(
                                            text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
                                          ),
                                          TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
                                          TextEditingController(),
                                          MultiSelectController(),
                                          false,
                                          null));
                                      mealTaskList[index].isDelete = true;
                                    } else {
                                      mealTaskList[index].errorMessage = AppStrings.nameError;
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      mealTaskList[index].isDelete ? AppStrings.deleteStr : AppStrings.addMoreStr,
                                      style: AppFonts.kPoppinsMedium.copyWith(color: AppColors.kDarkBlue, fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      mealTaskList[index].isDelete ? CupertinoIcons.minus_circle : CupertinoIcons.plus_circled,
                                      color: AppColors.kDarkBlue,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                label: AppStrings.okStr,
                onClick: () {
                  ShowToast(msg: "Done");
                }),
            SizedBox(
              height: 20,
            )
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
