import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../constants/colors.dart';
import '../../constants/data_provider.dart';
import '../../constants/fonts.dart';
import '../../constants/helper.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController destinationNameController = TextEditingController();
  TextEditingController travelStartDateController = TextEditingController();
  TextEditingController travelEndDateController = TextEditingController();
  TextEditingController travelDueTimeController = TextEditingController();
  TextEditingController addItemNameController = TextEditingController();

  final MultiSelectController _multiSelectController = MultiSelectController();
  String? startDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now()),
      endDate = DateFormat(AppStrings.dateFormatStr).format(DateTime.now());
  String? startTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now()),
      endTime = DateFormat(AppStrings.timeFormatStr).format(DateTime.now());

  List<String> selectedAssignee = [];
  List<String> itemList = [];
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
      isEdit = args?["isEdit"] != null;
      setState(() {});
    });
  }

  void addItem() {
    if (addItemNameController.text.trim().isNotEmpty) {
      itemList.add(addItemNameController.text);
      addItemNameController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: (isEdit) ? AppStrings.editTravelChecklistStr : AppStrings.addTravelChecklistStr,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21, top: 15),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppStrings.travelDateStr,
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
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppStrings.dueTimeStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: size.width * 0.35,
                          child: CustomTextField(
                            readOnly: true,
                            onClick: () async {
                              startTime = await Helper.selectTime(context) ?? startTime;
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
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppStrings.itemNameStr,
                          style: AppFonts.kPoppinsMedium.copyWith(color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          children: List.generate(
                            itemList.length,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.only(
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
                                      margin: const EdgeInsets.symmetric(horizontal: 6),
                                      width: 38,
                                      height: 38,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(19), color: AppColors.kDarkBlue.withOpacity(0.10)),
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        CustomTextField(
                          controller: addItemNameController,
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(6),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(19), color: AppColors.kDarkBlue.withOpacity(0.10)),
                            child: IconButton(
                              onPressed: addItem,
                              icon: const Icon(
                                Icons.add,
                                color: AppColors.kDarkBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
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
                          height: 25,
                        ),
                        if (isEdit) ...[
                          Text(
                            AppStrings.taskStatusStr,
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              DataProvider.taskStatusList.length,
                              (index) {
                                return Expanded(
                                  child: ListTile(
                                    dense: true,
                                    horizontalTitleGap: 2,
                                    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
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
                                      DataProvider.taskStatusList[index],
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          side: const BorderSide(
                            color: AppColors.kDarkBlue,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            30,
                          ))),
                      child: Text(
                        AppStrings.cancelStr,
                        style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: AppColors.kDarkBlue),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: validateTravelChecklist,
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: AppColors.kLiteBlue,
                          side: const BorderSide(color: Colors.transparent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            30,
                          ))),
                      child: Text(
                        AppStrings.saveStr,
                        style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
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
