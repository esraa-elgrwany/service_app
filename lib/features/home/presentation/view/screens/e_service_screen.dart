import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/home/presentation/view/widgets/servive_card.dart';
import 'package:service_app/l10n/app_localizations.dart';

class ServiceScreen extends StatelessWidget{
  static const String routeName="serviceScreen";
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.services,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
       surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ServiceCard(
              title: AppLocalizations.of(context)!.addNewService,
              subtitle: AppLocalizations.of(context)!.createManage,
              icon: Icons.add_box_rounded,
              color:Colors.teal,
              onTap: () {
                Navigator.pushNamed(context, 'addServiceScreen');
              },
            ),
            SizedBox(height: 24.h),
            ServiceCard(
              title: AppLocalizations.of(context)!.allServices,
              subtitle: AppLocalizations.of(context)!.viewServices,
              icon: Icons.list_alt_rounded,
              color: primaryColor,
              onTap: () {
                Navigator.pushNamed(context, 'viewServiceScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}

