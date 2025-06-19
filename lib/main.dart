import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/core/cache/shared_preferences.dart';
import 'package:service_app/core/utils/observer.dart';
import 'package:service_app/core/utils/styles/my_theme.dart';
import 'package:service_app/features/auth/presentation/view/phone_num_screen.dart';
import 'package:service_app/features/auth/presentation/view/sign_up_screen.dart';
import 'package:service_app/features/auth/presentation/view/verification_screen.dart';
import 'package:service_app/features/home/presentation/view/screens/e_service_screen.dart';
import 'package:service_app/features/service/add_service/presentation/view/screens/add_service_screen.dart';
import 'package:service_app/features/service/add_service/presentation/view/screens/add_service_second_screen.dart';
import 'package:service_app/features/service/add_service/presentation/view/screens/map_picker_screen.dart';
import 'package:service_app/features/service/get_service/presentation/view/screens/view_service_screen.dart';
import 'package:service_app/features/setting/model_view/setting_cubit.dart';
import 'package:service_app/features/setting/view/setting_screen.dart';
import 'features/home/presentation/view/screens/home_screen.dart';
import 'features/news/presentation/view/screens/news_details_screen.dart';
import 'features/news/presentation/view/screens/news_screen.dart';
import 'features/service/get_service/presentation/view/screens/service_details_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheData.init();
  String start;
  int? userId = CacheData.getData(key: "userId");
  if (userId == null) {
    start = PhoneNumScreen.routeName;
  } else {
    start = HomeScreen.routeName;
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    BlocProvider(create: (context) => SettingCubit(), child: MyApp(start)),
  );
}

class MyApp extends StatelessWidget {
  String start;

  MyApp(this.start);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ScreenUtilInit(
            designSize: const Size(412, 870),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: Locale(SettingCubit.get(context).languageCode),
                  debugShowCheckedModeBanner: false,
                  initialRoute: start,
                  routes: {
                    SignUpScreen.routeName: (context) => SignUpScreen(),
                    HomeScreen.routeName: (context) => HomeScreen(),
                    SettingScreen.routeName: (context) => SettingScreen(),
                    PhoneNumScreen.routeName: (context) => PhoneNumScreen(),
                    MapPickerScreen.routeName: (context) => MapPickerScreen(),
                    VerificationScreen.routeName: (context) =>
                        VerificationScreen(),
                    ServiceScreen.routeName: (context) => ServiceScreen(),
                    ServiceDetailsScreen.routeName: (context) =>
                        ServiceDetailsScreen(),
                    AddServiceScreen.routeName: (context) => AddServiceScreen(),
                    AddServiceSecondScreen.routeName: (context) =>
                        AddServiceSecondScreen(),
                    ViewServiceScreen.routeName: (context) =>
                        ViewServiceScreen(),
                    NewsScreen.routeName: (context) => NewsScreen(),
                    NewsDetailsScreen.routeName: (context) =>
                        NewsDetailsScreen(),
                  },
                  themeMode: SettingCubit.get(context).modeApp,
                  theme: MyThemeData.lightTheme,
                  darkTheme: MyThemeData.darkTheme,
                ));
      },
    );
  }
}
