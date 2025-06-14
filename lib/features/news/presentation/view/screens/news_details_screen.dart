import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget{
  static const String routeName="newsDetailsScreen";
  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Details',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)
                ) ,
                child: Image.asset("assets/images/news_item.png")
              ),
              Padding(
                padding: const EdgeInsets.all(16).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    "Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
        
                   Container(
                     height: MediaQuery.of(context).size.height-400.h,
                      child: Card(
                        color:  Theme.of(context).colorScheme.onBackground,
                        margin: EdgeInsets.symmetric(vertical:12),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: Colors.transparent
                            )
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(24).w,
                            child: Column(
                              children: [
                                Text( """Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders, Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders, Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leadersRaphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders scored a penalty in the eighth minute of stoppage time as La Liga leaders time as La Liga leaders scored a penalty in the eighth minute of stoppage time as La Liga leaders Raphinha scored a penalty in the eighth minute. Raphinha scored a penalty in the eighth minute of stoppage time as La Liga leaders.""",style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        Text("View Full Article",style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),),
                        IconButton(onPressed:() {
                          Uri url=Uri.parse("https://news.google.com/home?hl=en-US&gl=US&ceid=US:en");
                          launchUrl(url);
                        }, icon: Icon(Icons.arrow_right_outlined,
                          color:Colors.green,size: 35,))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
