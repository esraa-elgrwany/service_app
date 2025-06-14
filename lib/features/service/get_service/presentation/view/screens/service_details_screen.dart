import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailsScreen extends StatelessWidget {
  static const String routeName = "serviceDetailsScreen";

  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Services Details',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            color: Theme.of(context).colorScheme.onBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child:Container(
              height: MediaQuery.of(context).size.height-200,
              child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Title",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary)),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                              "content",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green[200]
                        ),
                        child: Center(
                          child: Image.asset("assets/images/content-writing.png",width:32.w,height: 32.h,),
                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (context, index) =>
                    Divider(
                      endIndent: 20,
                      indent: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                itemCount:7),)
          ),
        ),
      )
    );
  }
}


class AttachmentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('المرفقات', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.attach_file, color: Colors.red),
                Text('1'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.download, color: Colors.blue),
                Text('2025-05-15'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReplySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('الرد من مقدم الخدمة',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2025-05-18'),
                Text('2025-05-15'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
