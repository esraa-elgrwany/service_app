import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/cache/shared_preferences.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/auth/presentation/view/verification_screen.dart';
import 'package:service_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/text_form_num.dart';

class PhoneNumScreen extends StatefulWidget {
  static const String routeName = "phoneNumScreen";

  const PhoneNumScreen({super.key});

  @override
  State<PhoneNumScreen> createState() => _PhoneNumScreenState();
}

class _PhoneNumScreenState extends State<PhoneNumScreen> {
  final TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child:  BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool isLoading = state is SendOtpLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  surfaceTintColor: Colors.transparent,
                  title: Text(
                    "Sign In",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.background,
                          elevation: 8,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  topLeft: Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.background,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Phone number",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  TextFormNum(
                                      controller: phoneController,
                                      hint: "phone number",
                                      icon: Icons.call,
                                      validateTxt:
                                          "please enter your phone number"),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    "Enter 8 digits without the country code..",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is SendOtpError) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.grey[200],
                                            title: Text(
                                              "Error",
                                              style:
                                                  TextStyle(color: primaryColor),
                                            ),
                                            content: Text(
                                              state.failures.errorMsg,
                                              style:
                                                  TextStyle(color: primaryColor,fontSize: 16.sp),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("okay",
                                                      style: TextStyle(
                                                          color: Colors.white))),
                                            ],
                                          ),
                                        );
                                      } else if (state is SendOtpSuccess) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                "OTP sent successfully!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              ),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 4),
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 4)),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationScreen()),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                                  CacheData.saveId(data:phoneController.text, key:"phone");
                                                  AuthCubit.get(context).sendOtp(
                                                    phone:phoneController.text);
                                               }
                                              },
                                              child: Text(
                                                "Send Verification Code",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0XFF1d194a),
                                                padding: EdgeInsets.all(12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(12)),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
