import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/features/home/presentation/view/widgets/home_card_item.dart';
import 'package:service_app/features/setting/view/setting_screen.dart';
import 'package:service_app/l10n/app_localizations.dart';

import '../../../../../core/cache/shared_preferences.dart';

class HomeScreen extends StatelessWidget{
  static const String routeName="homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": AppLocalizations.of(context)!.services,
        "image": "assets/images/computer_11516928.png",
        "route":"serviceScreen"
      },
      {
        "title": AppLocalizations.of(context)!.news,
        "image": "assets/images/freedom-press_10642288.png",
        "route":"newsScreen"
      },
    ];
    return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:32.h),
                Row(
                  children: [
                    Image.asset("assets/images/people_8532963.png",width:36,height: 36,),
                    SizedBox(width: 12.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(
                            AppLocalizations.of(context)!.welcome,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.onSurface),
                          ),
                          Text(CacheData.getData(key: "name") ?? "",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.grey
                              )),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, SettingScreen.routeName);
                      }, icon:Icon(Icons.settings,size:24,),color:Theme.of(context).colorScheme.onSurface),
                  ],
                ),
                SizedBox(height:16.h),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      childAspectRatio:.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return HomeCardItem(
                        imageUrl: menuItems[index]["image"],
                        title: menuItems[index]["title"],
                        route:menuItems[index]["route"] ,);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
