import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/utils/constants.dart';
import 'package:service_app/features/news/presentation/view_model/news_cubit.dart';

class NewsItem extends StatelessWidget {
  int index;

  NewsItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final news = NewsCubit.get(context).news;
    if (news.isEmpty || index >= news.length) {
      return Center(
        child: Text(
          "No News Available",
          style: TextStyle(fontSize: 18.sp, color: Colors.red),
        ),
      );
    }
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(bottom: 16),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                child: Image.network(
                  "${Constants.baseUrl}${news[index].image}",
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200.h,
                      color: Colors.grey.shade400,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image,
                              size: 48.sp, color: Colors.black),
                          SizedBox(height: 8.h),
                          Text(
                            "Image failed to load",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  news[index].title ?? "There is no title",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        news[index].category ?? "There is no category",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
               SizedBox(height: 6.h,),
               Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "By ${news[index].author} • ${news[index].date}",
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
