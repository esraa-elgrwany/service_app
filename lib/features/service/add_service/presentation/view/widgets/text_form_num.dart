import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/core/utils/styles/colors.dart';

class TextFormNum extends StatelessWidget{
  final TextEditingController controller;
  String hint;
  String validateTxt;
  IconData icon;
   TextFormNum( {required this.controller,
     required this.hint,
     required this.validateTxt,required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     style:  TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        filled: true,
        fillColor: greyColor,
        suffixIcon: Icon(
            icon,
            color: primaryColor,size: 28.sp,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color:  greyColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color:  greyColor,
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
