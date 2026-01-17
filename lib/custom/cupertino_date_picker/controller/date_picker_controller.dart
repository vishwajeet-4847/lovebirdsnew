import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/constant.dart';

class DatePickerController extends GetxController {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  DateTime selectedDate = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  String selectedDateString = ''; // formatted string

  @override
  void onInit() {
    super.onInit();
    selectedDateString = _dateFormat.format(selectedDate); // initialize string
  }

  String get date => selectedDateString;

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    selectedDateString = _dateFormat.format(newDate); // update formatted string

    update([AppConstant.idUpdateDate]);

    log("Selected Date: $selectedDate");
    log("Formatted Date: $selectedDateString");
  }
}
