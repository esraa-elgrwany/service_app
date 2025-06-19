import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/core/utils/styles/colors.dart';

class DropDownContainer extends StatelessWidget{
  String text;
  bool isLocation;
  DropDownContainer({required this.text,required this.isLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:greyColor,
        border: Border.all(color:greyColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color:Colors.black87, fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          Spacer(),
          InkWell(
            onTap: () {
            },
              child:isLocation?Icon(Icons.location_on_outlined,size:28.sp,color: primaryColor) :Icon(Icons.arrow_drop_down,size:28.sp,color: primaryColor)),
        ],
      ),
    );
  }
}
