import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/core/utils/styles/colors.dart';

class TextFormWidget extends StatelessWidget{
  final TextEditingController controller;
  String hint;
  String validateTxt;
  int maxLine;
  IconData icon;
  TextFormWidget(
      {required this.controller,
        required this.hint,
        required this.validateTxt,required this.maxLine,required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color:Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        filled: true,
        fillColor: greyColor,
        suffixIcon: Icon(
            icon,
            color: primaryColor,size: 24.sp,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: greyColor
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: greyColor
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: greyColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: greyColor)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateTxt;
        }
        return null;
      },
    );
  }
}