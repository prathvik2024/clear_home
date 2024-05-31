import 'dart:developer';

import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:clear_home/widgets/show_toast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/fonts.dart';

class CreateGeneralTask extends StatefulWidget {
  const CreateGeneralTask({super.key});

  @override
  State<CreateGeneralTask> createState() => _CreateGeneralTaskState();
}

class _CreateGeneralTaskState extends State<CreateGeneralTask> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<String> assigneeList = ["Family Member 1", "Family Member 2", "Family Member 3", "Family Member 4"];

  List<String> selectedAssignee = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.createGeneralStr,
      ),
      body: Container(
        height: height,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21),
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
                            controller: taskNameController,
                            hintText: AppStrings.startDateHintStr,
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
                            contentPadding: EdgeInsets.zero,
                            controller: taskNameController,
                            hintText: AppStrings.startDateHintStr,
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
                            controller: taskNameController,
                            hintText: AppStrings.taskStartTimeStr,
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
                            contentPadding: EdgeInsets.zero,
                            controller: taskNameController,
                            hintText: AppStrings.taskEndTimeStr,
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
                CustomTextField(
                  controller: taskDescController,
                  keyboardType: TextInputType.multiline,
                  textLabel: AppStrings.taskDescStr,
                  minLines: 6,
                  borderRadius: 15,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(label: AppStrings.saveStr, onClick: () {}),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
