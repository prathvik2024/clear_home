import 'package:clear_home/constants/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/helper.dart';
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: CustomTextField(
                            readOnly: true,
                            onClick: () async {
                              startDate = await Helper.selectDate(context) ?? startDate;
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.kDarkBlue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          DataProvider.daysName.length,
                          (index) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  minimumSize: Size.zero),
                              onPressed: () {
                                selectedIndex = index;
                                setState(() {});
                              },
                              child: Text(
                                DataProvider.daysName[index],
                                style: AppFonts.kPoppinsRegular
                                    .copyWith(fontSize: 14, color: (selectedIndex == index) ? AppColors.kDarkBlue : Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: List.generate(
                        DataProvider.mealTaskList.length,
                        (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                onChange: (input) {
                                  if (Validator.isAlpha(input: input.trim())) {
                                    DataProvider.mealTaskList[index].errorMessage = null;
                                  } else {
                                    DataProvider.mealTaskList[index].errorMessage = AppStrings.nameError;
                                  }
                                  setState(() {});
                                },
                                errorText: DataProvider.mealTaskList[index].errorMessage,
                                controller: DataProvider.mealTaskList[index].mealTitleController,
                                textLabel: AppStrings.mealTitleStr,
                                hintText: AppStrings.hintName,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppStrings.timeStr,
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
                                            DataProvider.mealTaskList[index].mealStartTimeController.text = startTime ?? "";
                                            setState(() {});
                                          },
                                          controller: DataProvider.mealTaskList[index].mealStartTimeController,
                                          hintText: DataProvider.mealTaskList[index].mealStartTimeController.text,
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
                                            DataProvider.mealTaskList[index].mealEndTimeController.text = endTime ?? "";
                                            setState(() {});
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          controller: DataProvider.mealTaskList[index].mealEndTimeController,
                                          hintText: DataProvider.mealTaskList[index].mealEndTimeController.text,
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
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                controller: DataProvider.mealTaskList[index].mealMenuDetailsController,
                                keyboardType: TextInputType.multiline,
                                textLabel: AppStrings.mealDetailsStr,
                                minLines: 4,
                                maxLines: 8,
                                borderRadius: 15,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              MultiSelectDropDown(
                                controller: DataProvider.mealTaskList[index].multiSelectController,
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
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (DataProvider.mealTaskList[index].isDelete) {
                                    DataProvider.mealTaskList.removeAt(index);
                                  } else {
                                    if (DataProvider.mealTaskList[index].mealTitleController.text.trim().isNotEmpty) {
                                      DataProvider.mealTaskList.add(MealTaskModel(
                                          TextEditingController(),
                                          TextEditingController(
                                            text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
                                          ),
                                          TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now())),
                                          TextEditingController(),
                                          MultiSelectController(),
                                          false,
                                          null));
                                      DataProvider.mealTaskList[index].isDelete = true;
                                    } else {
                                      DataProvider.mealTaskList[index].errorMessage = AppStrings.nameError;
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DataProvider.mealTaskList[index].isDelete ? AppStrings.deleteStr : AppStrings.addMoreStr,
                                      style: AppFonts.kPoppinsMedium.copyWith(color: AppColors.kDarkBlue, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      DataProvider.mealTaskList[index].isDelete ? CupertinoIcons.minus_circle : CupertinoIcons.plus_circled,
                                      color: AppColors.kDarkBlue,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
