import 'package:clear_home/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'dart:math' as math;
import '../widgets/show_toast.dart';

class Helper {
  static Future<String?> selectDate(BuildContext context) async {
    final DateTime? pickDate =
        await showDatePicker(context: context, firstDate: DateTime.now(), initialDate: DateTime.now(), lastDate: DateTime(2025));
    if (pickDate != null) {
      return DateFormat(AppStrings.dateFormatStr).format(pickDate);
    } else {
      ShowToast(msg: AppStrings.somethingWentWrongError);
      return null;
    }
  }

  static Future<String?> selectTime(BuildContext context) async {
    final TimeOfDay? pickTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickTime != null) {
      return DateFormat(AppStrings.timeFormatStr)
          .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, pickTime.hour, pickTime.minute));
    } else {
      ShowToast(msg: AppStrings.somethingWentWrongError);
      return null;
    }
  }

  static List<String> getAssignee(List<ValueItem> input) {
    List<String> result = [];
    for (var item in input) {
      result.add(item.value);
    }
    return result;
  }

  static  Color colorGenerator() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);
  }
}
