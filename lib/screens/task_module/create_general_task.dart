import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:clear_home/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../constants/fonts.dart';
import '../../constants/helper.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey();

  final MultiSelectController _multiSelectController = MultiSelectController();

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
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        backgroundColor: AppColors.kHomeBg,
        appBar: CustomAppbar(
          screenName: AppStrings.createGeneralStr,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
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
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppStrings.taskDateStr,
                    style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.startStr,
                              style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              readOnly: true,
                              onClick: () async {
                                startDate = await Helper.selectDate(context) ?? startDate;
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
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.endStr,
                              style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              readOnly: true,
                              onClick: () async {
                                endDate = await Helper.selectDate(context) ?? endDate;
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
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppStrings.taskTimeStr,
                    style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.startStr,
                              style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              readOnly: true,
                              onClick: () async {
                                startTime = await Helper.selectTime(context) ?? startTime;
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
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.endStr,
                              style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              readOnly: true,
                              onClick: () async {
                                endTime = await Helper.selectTime(context) ?? endTime;
                                setState(() {});
                              },
                              validationCallback: (input) {
                                if (input == endTime) {
                                  return AppStrings.updateEndTimeError;
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
                  const SizedBox(
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
                  const SizedBox(
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
                    hint: AppStrings.assignedToStr,
                    onOptionSelected: (result) {},
                    fieldBackgroundColor: AppColors.kLiteBlue,
                    focusedBorderColor: Colors.transparent,
                    selectedOptionTextColor: AppColors.kLiteBlue,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    options: DataProvider.assigneeList.map((item) {
                      return ValueItem(
                        label: item,
                        value: item,
                      );
                    }).toList(),
                    selectionType: SelectionType.multi,
                    optionTextStyle: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                    chipConfig: const ChipConfig(
                      backgroundColor: AppColors.kLiteBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(label: AppStrings.saveStr, onClick: validateGeneralTask),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
