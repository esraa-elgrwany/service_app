import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/styles/colors.dart';

class Button extends StatelessWidget {
  String text;

  Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.h,
        width: MediaQuery
            .of(context)
            .size
            .width -160,
        decoration:
        BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
        child: Center(
          child: Text(text, style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),),
        )
    );
  }
}