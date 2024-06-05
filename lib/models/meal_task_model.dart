import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../constants/strings.dart';

class MealTaskModel {
  TextEditingController mealTitleController = TextEditingController();
  TextEditingController mealStartTimeController = TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now()));
  TextEditingController mealEndTimeController = TextEditingController(text: DateFormat(AppStrings.timeFormatStr).format(DateTime.now()));
  TextEditingController mealMenuDetailsController = TextEditingController();
  MultiSelectController multiSelectController = MultiSelectController();
  bool isDelete = false;
  String? errorMessage;

  MealTaskModel(this.mealTitleController, this.mealStartTimeController, this.mealEndTimeController, this.mealMenuDetailsController,
      this.multiSelectController, this.isDelete, this.errorMessage);
}
