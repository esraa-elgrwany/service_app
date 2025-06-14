import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/home/presentation/view/widgets/servive_card.dart';

class ServiceScreen extends StatelessWidget{
  static const String routeName="serviceScreen";
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Services',
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
            InkWell(
              onTap: () {
               // Navigator.push(context,MaterialPageRoute(builder:  (context) => AddServiceScreen(),));
              },
              child: ServiceCard(
                title: 'Add New Service',
                subtitle: 'Create and manage new services',
                icon: Icons.add_box_rounded,
                color:Colors.teal,
                onTap: () {
                  Navigator.pushNamed(context, 'addServiceScreen');
                },
              ),
            ),
            const SizedBox(height: 20),
            ServiceCard(
              title: 'All Services',
              subtitle: 'View, edit, or delete services',
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

