import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/utils/constants.dart';
import 'package:service_app/features/news/presentation/view_model/news_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const String routeName = "newsDetailsScreen";

  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Details',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => NewsCubit()..getNewsDetails(newsId: args),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is GetNewsDetailsLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            } else if (state is GetNewsDetailsError) {
              return Center(child: Text("Error: ${state.failures.errorMsg}"));
            } else if (state is GetNewsDetailsSuccess) {
              final newsItem = state.model.result;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.network(
                          "${Constants.baseUrl}${newsItem?.image}",
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              color: Colors.grey.shade200,
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
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16).w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${newsItem?.category} / ${newsItem?.title ?? "There is no title"}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height - 320.h,
                              child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Html(
                                        data: newsItem?.content,
                                        style: {
                                          "p": Style(
                                            fontSize: FontSize(14.sp),
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        },
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "View Full Article",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Uri url = Uri.parse(newsItem?.url ??
                                          "https://news.google.com/home?hl=en-US&gl=US&ceid=US:en");
                                      launchUrl(url);
                                    },
                                    icon: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Unexpected state"));
            }
          },
        ),
      ),
    );
  }
}
