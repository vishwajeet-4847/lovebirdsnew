// ignore_for_file: must_be_immutable

import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool filled;
  bool? obscureText;
  String? hintText;
  Color? fillColor;
  Color? hintTextColor;
  Color? cursorColor;
  Color? fontColor;
  double? hintTextSize;
  double? fontSize;
  int? maxLines;
  bool? readOnly;
  bool? enabled;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  Function(String)? onChange;
  String? initialValue;
  TextStyle? style;

  CustomTextField({
    super.key,
    this.onChange,
    required this.filled,
    this.obscureText,
    this.hintText,
    this.fillColor,
    this.fontColor,
    this.cursorColor,
    this.maxLines,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.hintTextColor,
    this.hintTextSize,
    this.fontSize,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.initialValue,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      enabled: enabled,
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChange,
      cursorColor: cursorColor,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      style: style ??
          AppFontStyle.styleW600(
            fontColor ?? AppColors.primaryColor,
            fontSize ?? 14,
          ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondaryColor),
        ),
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppFontStyle.styleW700(
          hintTextColor ?? AppColors.transparent,
          hintTextSize ?? 0.0,
        ),
      ),
    );
  }
}
