import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';
import '../../constants/validator.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/show_toast.dart';

class AddTravelChecklistScreen extends StatefulWidget {
  const AddTravelChecklistScreen({super.key});

  @override
  State<AddTravelChecklistScreen> createState() => _AddTravelChecklistScreenState();
}

class _AddTravelChecklistScreenState extends State<AddTravelChecklistScreen> {
  Map<String, dynamic>? args;
  bool isEdit = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController destinationNameController = TextEditingController();
  TextEditingController travelStartDateController = TextEditingController();
  TextEditingController travelEndDateController = TextEditingController();
  TextEditingController travelDueTimeController = TextEditingController();
  TextEditingController addItemNameController = TextEditingController();

  MultiSelectController _multiSelectController = MultiSelectController();
  String? startDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now()),
      endDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now());
  String? startTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
      endTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now());

  List<String> assigneeList = ["Family Member 1", "Family Member 2", "Family Member 3", "Family Member 4"];
  List<String> selectedAssignee = [];
  List<String> itemList = [];
  List<String> taskStatusList = [AppStrings.pendingStr, AppStrings.inProgressStr, AppStrings.completedStr];
  int taskStatus = 0;

  validateTravelChecklist() {
    if (_formKey.currentState!.validate()) {
      ShowToast(msg: "Done");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timestamp) {
      args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (args?["isEdit"] != null) {
        isEdit = true;
      } else {
        isEdit = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: (isEdit) ? AppStrings.editTravelChecklistStr : AppStrings.addTravelChecklistStr,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 21, right: 21, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: destinationNameController,
                          textLabel: AppStrings.destinationNameStr,
                          validationCallback: (input) =>
                              Validator.validate(input: input, type: ValidationType.isAlpha, errorMsg: AppStrings.nameError),
                          hintText: AppStrings.hintName,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppStrings.travelDateStr,
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
                                    controller: travelStartDateController,
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
                                    controller: travelEndDateController,
                                    hintText: endDate,
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
                        Text(
                          AppStrings.dueTimeStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: width * 0.35,
                          child: CustomTextField(
                            enabled: false,
                            onClick: () async {
                              startTime = await selectTime();
                              setState(() {});
                            },
                            controller: travelDueTimeController,
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
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppStrings.itemNameStr,
                          style: AppFonts.kPoppinsMedium.copyWith(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        CustomTextField(
                          controller: addItemNameController,
                          suffixIcon: Container(
                            margin: EdgeInsets.all(6),
                            width: 38,
                            height: 38,
                            child: IconButton(
                              onPressed: () {
                                if (addItemNameController.text.trim().isNotEmpty) {
                                  itemList.insert(0, addItemNameController.text);
                                  addItemNameController.clear();
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: AppColors.kDarkBlue,
                              ),
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(19), color: AppColors.kDarkBlue.withOpacity(0.10)),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Column(
                          children: List.generate(
                            itemList.length,
                            (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                width: width,
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                  left: 15,
                                ),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.black12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      itemList[index],
                                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 6),
                                      width: 38,
                                      height: 38,
                                      child: IconButton(
                                        onPressed: () {
                                          itemList.removeAt(index);
                                          setState(() {});
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SvgPicture.asset(
                                            AppStrings.svgMinus,
                                            color: AppColors.kDarkBlue,
                                          ),
                                        ),
                                      ),
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(19), color: AppColors.kDarkBlue.withOpacity(0.10)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                          height: 25,
                        ),
                        if (isEdit) ...[
                          Text(
                            AppStrings.taskStatusStr,
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              taskStatusList.length,
                              (index) {
                                return Container(
                                  width: width * 0.28,
                                  child: ListTile(
                                    dense: true,
                                    horizontalTitleGap: 2,
                                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                    contentPadding: EdgeInsets.zero,
                                    leading: Radio(
                                      activeColor: AppColors.kDarkBlue,
                                      visualDensity: VisualDensity.compact,
                                      value: index,
                                      groupValue: taskStatus,
                                      onChanged: (value) {
                                        taskStatus = value!;
                                        setState(() {});
                                      },
                                    ),
                                    title: Text(
                                      taskStatusList[index],
                                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppStrings.cancelStr,
                        style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          side: BorderSide(
                            color: AppColors.kDarkBlue,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            30,
                          ))),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: validateTravelChecklist,
                      child: Text(
                        AppStrings.saveStr,
                        style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          backgroundColor: AppColors.kLiteBlue,
                          side: BorderSide(color: Colors.transparent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            30,
                          ))),
                    ))
                  ],
                ),
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
