import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/models/recent_task_model.dart';
import 'package:clear_home/models/task_item_model.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/data_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  Map<String, dynamic>? args;

  TextEditingController addDescriptionController = TextEditingController();
  int taskStatus = 0;

  String? appBarName;
  RecentTaskModel? model;
  TaskType? type;
  late Size size;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timestamp) {
      size = MediaQuery.of(context).size;
      args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (args?["modelData"] != null && args?["taskType"] != null) {
        model = args?["modelData"];
        type = TaskType.values.firstWhere((e) => e.toString() == args?["taskType"]);
        appBarName = DataProvider.dynamicAppBarMap[type];
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: appBarName,
        actionWidgets: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SvgPicture.asset(
                AppStrings.svgEdit,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: taskItem(AppStrings.taskTypeStr, model?.title ?? "", model?.icon ?? "")),
                          if (type == TaskType.TodayTask) ...[
                            Expanded(child: taskItem(AppStrings.taskTimeStr, AppStrings.taskTimeTitleStr, AppStrings.svgClock)),
                          ] else if (type == TaskType.UpcomingTask) ...[
                            Expanded(child: taskItem(AppStrings.taskDateStr, AppStrings.taskDateTitleStr, AppStrings.svgCalendar)),
                          ] else ...[
                            Expanded(child: taskItem(AppStrings.dueTimeStr, AppStrings.taskStartTimeStr, AppStrings.svgClock)),
                          ]
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (type == TaskType.UpcomingTask || type == TaskType.PastTask) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (type == TaskType.UpcomingTask) ...[
                              Expanded(child: taskItem(AppStrings.taskTimeStr, AppStrings.taskTimeTitleStr, AppStrings.svgClock)),
                            ] else if (type == TaskType.PastTask) ...<Widget>[
                              Expanded(child: taskItem(AppStrings.startDateStr, AppStrings.taskDateTitleStr, AppStrings.svgCalendar)),
                              Expanded(child: taskItem(AppStrings.endDateStr, AppStrings.taskDateTitleStr, AppStrings.svgCalendar)),
                            ]
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      Divider(
                        height: 1,
                        color: Colors.black.withOpacity(0.08),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (type != TaskType.PastTask) ...[
                        Text(
                          AppStrings.menuDetailsStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          AppStrings.descriptionStr,
                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ] else ...[
                        Text(
                          AppStrings.itemListStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        itemListView(DataProvider.itemList),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      Text(
                        AppStrings.assignedToStr,
                        style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      assigneeNameView(DataProvider.assigneeList),
                      const SizedBox(
                        height: 20,
                      ),
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
                                minLeadingWidth: 0,
                                dense: true,
                                horizontalTitleGap:0,
                                visualDensity: const VisualDensity(vertical: -4, horizontal: 1),
                                contentPadding: EdgeInsets.zero,
                                leading: Radio(
                                  materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                                  activeColor: AppColors.kDarkBlue,
                                  visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
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
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: addDescriptionController,
                        keyboardType: TextInputType.multiline,
                        textLabel: AppStrings.addCommentStr,
                        minLines: 4,
                        maxLines: 8,
                        borderRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(label: AppStrings.okStr, onClick: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemListView(List<TaskItemModel> list) => Wrap(
        children: List.generate(
          list.length,
          (index) {
            return Container(
              width:  size.width * 0.35,
              margin: EdgeInsets.only(top: (index > 1) ? 10 : 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      list[index].isSelect = !list[index].isSelect;
                      setState(() {});
                    },
                    child: Container(
                      width: Checkbox.width * 1.2,
                      height: Checkbox.width * 1.2,
                      padding: const EdgeInsets.all(4),
                      decoration:
                          BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(6)),
                      child: (list[index].isSelect)
                          ? SvgPicture.asset(
                              AppStrings.svgCheckboxTik,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    list[index].title,
                    style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget assigneeNameView(List<String> list) {
    return Wrap(
      children: List.generate(
        list.length,
        (index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            margin: const EdgeInsets.only(right: 10, top: 10),
            decoration: BoxDecoration(color: AppColors.kDarkBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(30)),
            child: Text(
              list[index],
              style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: AppColors.kDarkBlue),
            ),
          );
        },
      ),
    );
  }

  Widget taskItem(String heading, String title, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          heading,
          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black.withOpacity(0.60)),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              color: AppColors.kDarkBlue,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                title,
                maxLines: 2,
                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black,),
              ),
            ),
          ],
        )
      ],
    );
  }
}
