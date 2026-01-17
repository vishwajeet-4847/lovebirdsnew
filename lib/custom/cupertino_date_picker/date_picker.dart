import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showCupertinoDatePicker({required BuildContext context}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: GetBuilder<DatePickerController>(
          // id: AppConstant.idUpdateDate,
          builder: (logic) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text(EnumLocale.txtCancel.name.tr),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: CupertinoButton(
                    child: Text(EnumLocale.txtSave.name.tr),
                    onPressed: () {
                      logic.updateSelectedDate(logic.selectedDate);
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumYear: 1900,
                maximumYear: DateTime.now().year,
                initialDateTime: logic.selectedDate,
                onDateTimeChanged: (DateTime newDate) => logic.updateSelectedDate(newDate),
              ),
            ),
          ],
        );
      }),
    ),
  );
}
