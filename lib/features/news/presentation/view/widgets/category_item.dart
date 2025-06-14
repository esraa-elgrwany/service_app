import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget{
  String text;
   CategoryItem({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadiusDirectional.circular(16),
          ),
          child: Text(text,style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 16.sp,fontWeight:FontWeight.w600),
          ),
        ),
        )
      ],
    );
  }
}