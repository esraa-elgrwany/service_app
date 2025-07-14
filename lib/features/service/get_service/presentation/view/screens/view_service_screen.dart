import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:service_app/features/service/get_service/presentation/view/screens/service_details_screen.dart';
import 'package:service_app/features/service/get_service/presentation/view/widgets/service_item.dart';
import 'package:service_app/features/service/get_service/presentation/view_model/get_service_cubit.dart';
import 'package:service_app/l10n/app_localizations.dart';

class ViewServiceScreen extends StatefulWidget {
  static const String routeName = "viewServiceScreen";

  const ViewServiceScreen({super.key});

  @override
  State<ViewServiceScreen> createState() => _ViewServiceScreenState();
}

class _ViewServiceScreenState extends State<ViewServiceScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allServices,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => GetServiceCubit()..getServices(),
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
              Expanded(
                child: BlocBuilder<GetServiceCubit, GetServiceState>(
                    builder: (context, state) {
                  if (state is GetServiceLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  } else if (state is GetServiceError) {
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
                  } else if (state is GetServiceSuccess) {
                    final services = context.read<GetServiceCubit>().services;
                    if (services.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book_outlined,
                                color: Colors.grey, size: 40.sp),
                            SizedBox(height: 8.h),
                            Text(
                              "No Services Found",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ServiceDetailsScreen.routeName,
                                arguments: services[index].id!
                              );
                            },
                            child: ServiceItem(
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
      ),
    );
  }
}
