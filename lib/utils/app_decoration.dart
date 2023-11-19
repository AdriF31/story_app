import 'package:flutter/material.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

InputDecoration customInputDecoration(
    {String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText}) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: text16WhiteMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:const BorderSide(color: divider)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(color: divider)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(color: divider)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red),
      ),
      prefixIconColor: divider,
      suffixIconColor: divider,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon);
}
