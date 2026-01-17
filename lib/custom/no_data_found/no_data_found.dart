// ignore_for_file: must_be_immutable

import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoDataFoundWidget extends StatelessWidget {
  String? text;
  NoDataFoundWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(AppAsset.imgEmptyData, height: 130)),
        10.height,
        Text(
          text ?? EnumLocale.txtNoDataFound.name.tr,
          style: AppFontStyle.styleW400(AppColors.whiteColor, 16),
        ),
      ],
    );
  }
}
