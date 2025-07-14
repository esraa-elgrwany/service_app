import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/service/get_service/presentation/view_model/get_service_cubit.dart';
import 'package:service_app/l10n/app_localizations.dart';

class ServiceItem extends StatelessWidget{
  int index;
   ServiceItem({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    final services = GetServiceCubit.get(context).services;

    if (services.isEmpty || index >= services.length) {
      return Center(
        child: Text(
          "No Services Available",
          style: TextStyle(fontSize: 18.sp, color: Colors.red),
        ),
      );
    }
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    services[index].name==""?"No title":
                   services[index].name??"No title",
                    style:  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.reference}:", style: TextStyle(fontSize: 16.sp)),
                Flexible(
                  flex:8,
                    child: Text(services[index].reference??"no reference",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.sp))),
                Spacer(),
                Text(
                  formatDateString(services[index].date),
                  style:  TextStyle(color: Colors.grey,fontSize: 16.sp),
                ),
                SizedBox(width:4.w,),
                Icon(Icons.date_range_outlined,color:Theme.of(context).colorScheme.primary,size: 22.sp,),

              ],
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                Image.asset("assets/images/categories_6521775.png",width:24.w,height: 24.h,),
                SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.mainCat}:", style: TextStyle(fontSize: 16.sp)),
                Text(services[index].category?.name??"no category"),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                Image.asset("assets/images/list_18542777.png",width:24.w,height: 24.h,),
                 SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.subCat}:", style: TextStyle(fontSize: 16.sp)),
                Text(services[index].subCategory?.name??"no Sub category"),
              ],
            ),
             SizedBox(height: 8.h), // Status
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.stage}:", style: TextStyle(
                  color:Colors.green.withOpacity(.8) ,
                  fontWeight: FontWeight.w600,
                    fontSize: 16.sp
                ),
                ),
                Text(
                  services[index].stage?.name??"no stage",
                  style: TextStyle(
                    color: Colors.green.withOpacity(.8),
                    fontWeight: FontWeight.w600,
                      fontSize: 16.sp
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  String formatDateString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "no date";
    try {
      DateTime parsed = DateTime.parse(rawDate);
      return DateFormat('yyyy-MM-dd').format(parsed);
    } catch (e) {
      return "invalid date";
    }
  }
}

