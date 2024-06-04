import 'dart:developer';

import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/models/task_item_model.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:clear_home/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../constants/fonts.dart';

class CreateGeneralTask extends StatefulWidget {
  const CreateGeneralTask({super.key});

  @override
  State<CreateGeneralTask> createState() => _CreateGeneralTaskState();
}

class _CreateGeneralTaskState extends State<CreateGeneralTask> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();
  TextEditingController taskStartDateController = TextEditingController();
  TextEditingController taskEndDateController = TextEditingController();
  TextEditingController taskStartTimeController = TextEditingController();
  TextEditingController taskEndTimeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  MultiSelectController _multiSelectController = MultiSelectController();

  List<String> assigneeList = ["Family Member 1", "Family Member 2" "Family Member 3", "Family Member 4"];
  List<String> selectedAssignee = [];

  String? startDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now()),
      endDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now());
  String? startTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
      endTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now());


  void validateGeneralTask() {
    if (_formKey.currentState!.validate()) {
      ShowToast(msg: "Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.createGeneralStr,
      ),
      body: Container(
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: taskNameController,
                  textLabel: AppStrings.taskNameStr,
                  validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isAlpha),
                  hintText: AppStrings.buyGroceriesStr,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  AppStrings.taskDateStr,
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
                              startDate = await selectDate();
                              setState(() {});
                            },
                            controller: taskStartDateController,
                            hintText: startDate,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                              child: SvgPicture.asset(
                                AppStrings.svgCalendar,
                                width: 24,
                                height: 24,
                                color: Colors.black.withOpacity(0.20),
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
                              endDate = await selectDate();
                              setState(() {});
                            },
                            contentPadding: EdgeInsets.zero,
                            controller: taskEndDateController,
                            hintText: endDate,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                              child: SvgPicture.asset(
                                AppStrings.svgCalendar,
                                width: 24,
                                height: 24,
                                color: Colors.black.withOpacity(0.20),
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
                Text(
                  AppStrings.taskTimeStr,
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
                              setState(() {});
                            },
                            controller: taskStartTimeController,
                            hintText: startTime,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                              child: SvgPicture.asset(
                                AppStrings.svgClock,
                                width: 24,
                                height: 24,
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
                              setState(() {});
                            },
                            validationCallback: (input) {
                              if (input == taskEndTimeController.text) {
                                return "Update end time!";
                              }
                              return null;
                            },
                            contentPadding: EdgeInsets.zero,
                            controller: taskEndTimeController,
                            hintText: endTime,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                              child: SvgPicture.asset(
                                AppStrings.svgClock,
                                width: 24,
                                height: 24,
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
                  controller: taskDescController,
                  keyboardType: TextInputType.multiline,
                  textLabel: AppStrings.taskDescStr,
                  minLines: 5,
                  maxLines: 8,
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 25,
                ),
                MultiSelectDropDown(
                  controller: _multiSelectController,
                  inputDecoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.black12,
                      )),
                  hint: "Assign to",
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
                Spacer(),
                CustomButton(label: AppStrings.saveStr, onClick: validateGeneralTask),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  List<String> getAssignee(List<ValueItem> input) {
    List<String> result = [];
    input.forEach((item) {
      result.add(item.value);
    });
    return result;
  }
}
