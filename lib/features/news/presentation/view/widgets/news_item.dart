import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsItem extends StatelessWidget{
  int index;
  NewsItem({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(bottom: 16),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            child: Image.asset("assets/images/news_item.png",fit: BoxFit.cover,height: 230.h,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Raphinha scored a penalty in the eighth minute of stoppage ",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              """Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders, Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leadersRaphinha
               """,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
