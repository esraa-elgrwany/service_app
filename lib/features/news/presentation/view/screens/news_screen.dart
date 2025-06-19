import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:service_app/features/news/presentation/view/screens/news_details_screen.dart';
import 'package:service_app/features/news/presentation/view/widgets/news_item.dart';
import 'package:service_app/features/news/presentation/view_model/news_cubit.dart';
import '../widgets/category_item.dart';

class NewsScreen extends StatefulWidget {
  static const String routeName = "newsScreen";

  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> category = [
    "Sports",
    "Politics",
    "Health",
    "Business",
    "Celebrities"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 22.sp),
          ),
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context) => NewsCubit()..getNews(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBarWidget(
                  controller: searchController,
                  onSearch: (query) {},
                  onClear: () {},
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 80.h,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CategoryItem(text: category[index]));
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<NewsCubit, NewsState>(
                      builder: (context, state) {
                    if (state is GetNewsLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    } else if (state is GetNewsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.red, size: 50.sp),
                            SizedBox(height: 12.h),
                            Text(
                              "An error occurred.",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.sp),
                            ),
                          ],
                        ),
                      );
                    } else if (state is GetNewsSuccess) {
                      final news = context.read<NewsCubit>().news;
                      if (news.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.book_outlined,
                                  color: Colors.grey, size: 40.sp),
                              SizedBox(height: 8.h),
                              Text(
                                "No News Found",
                                style: TextStyle(
                                    fontSize: 20.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount:news.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  NewsDetailsScreen.routeName,
                                  arguments: news[index].id!
                                );
                              },
                              child: NewsItem(
                                index: index,
                              ));
                        },
                      );
                    }
                    ;
                    return SizedBox();
                  }),
                )
              ],
            ),
          ),
        ));
  }
}
