import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_app/features/service/get_service/presentation/view_model/get_service_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/service_details_model.dart';


class ServiceDetailsScreen extends StatelessWidget {
  static const String routeName = "serviceDetailsScreen";

  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (_) => GetServiceCubit()..getServiceDetails(serviceId: args),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Services Details',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocBuilder<GetServiceCubit, GetServiceState>(
          builder: (context, state) {
            if (state is GetServiceDetailsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.green,));
            } else if (state is GetServiceDetailsError) {
              return Center(child: Text("Error: ${state.failures.errorMsg}"));
            } else if (state is GetServiceDetailsSuccess) {
              final service = state.model.result?.service;
              final fields = service?.fieldsConfig
                  ?.where((field) =>
              field.status != "no" &&
                  !(field.status == "optional" &&
                      (_getServiceValue(service!, field.name ?? '') == "—")))
                  .toList() ??
                  [];

              final staticFields = {
                'Name': service?.name,
                'Phone': service?.phone,
                'Date': service?.date,
                'National ID': service?.nationalId,
                'Stage': service?.stage,
                'Category': service?.category,
                'Subcategory': service?.subCategory,
                'Service Type': service?.serviceType,
                'Service Type ID': service?.serviceTypeId.toString(),
                //'Partner': service?.partner,
              };

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Theme.of(context).colorScheme.onBackground,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: staticFields.length + fields.length,
                    itemBuilder: (context, index) {
                      if (index < staticFields.length) {
                        final key = staticFields.keys.elementAt(index);
                        final value = staticFields[key] ?? '—';
                        return _buildDetailItem(context, key, value);
                      } else {
                        final field = fields[index - staticFields.length];
                        final label = field.label ?? field.name ?? '—';
                        final value = _getServiceValue(service!, field.name ?? '—');
                        final optionalSuffix = field.status == 'optional' ? " (optional)" : "";
                        return _buildDetailItem(context, "$label$optionalSuffix", value);
                      }
                    },
                    separatorBuilder: (context, index) => Divider(
                      endIndent: 20,
                      indent: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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

  Widget _buildDetailItem(BuildContext context, String title, String value) {
    final isLocation = title.toLowerCase().contains("location");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                isLocation
                    ? GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse(value);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Could not launch map")),
                      );
                    }
                  },
                  child: Text(
                    value,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
                    : Text(
                  value,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.green[200],
            ),
            child: Center(
              child: Image.asset(
                "assets/images/content-writing.png",
                width: 32.w,
                height: 32.h,
              ),
            ),
          ),
        ],
      ),
    );
  }


  String _getServiceValue(Service service, String fieldName) {
    final Map<String, dynamic> serviceMap = service.toJson();
    final value = serviceMap[fieldName];
    if (value == null || value.toString().isEmpty) return "—";
    return value.toString();
  }
}
