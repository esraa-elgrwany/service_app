import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:service_app/core/cache/shared_preferences.dart';
import 'package:service_app/features/auth/presentation/view/sign_up_screen.dart';
import 'package:service_app/features/auth/presentation/view/widgets/button.dart';
import 'package:service_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:service_app/features/home/presentation/view/screens/home_screen.dart';

import '../../../../core/utils/styles/colors.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = "verificationScreen";

  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var code = '';
  String phone=CacheData.getData(key: "phone");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool isLoading = state is SendOtpLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  surfaceTintColor: Colors.transparent,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    "Verification",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Enter the OTP code sent to your number",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Pinput(
                                  length: 6,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  keyboardType: TextInputType.number,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  onChanged: (value) {
                                    setState(() {
                                      code = value;
                                    });
                                    print('Changed:,$value');
                                  },
                                  onCompleted: (value) {
                                    print('Completed:,$value');
                                  },
                                  onSubmitted: (value) {
                                    print('Submitted:,$value');
                                  },
                                  defaultPinTheme: PinTheme(
                                    height: 45.h,
                                    width: 45.w,
                                    textStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topLeft: Radius.circular(12)),
                                    ),
                                  ),
                                  focusedPinTheme: PinTheme(
                                    height: 45.h,
                                    width: 45.w,
                                    textStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topLeft: Radius.circular(12)),
                                    ),
                                  ),
                                  submittedPinTheme: PinTheme(
                                    height: 45.h,
                                    width: 45.w,
                                    textStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topLeft: Radius.circular(12)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocConsumer<AuthCubit, AuthState>(
                                      listener: (context, state) {
                                        {
                                          if (state is VerifyOtpErrorState) {
                                            final msg = state.failures.errorMsg.toLowerCase();

                                            if (msg.contains("signup required")) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => SignUpScreen(),
                                                ),
                                              );
                                            }else {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: Colors
                                                          .grey[200],
                                                      title: Text(
                                                        "Error",
                                                        style: TextStyle(
                                                            color: primaryColor),
                                                      ),
                                                      content: Text(
                                                        state.failures.errorMsg,
                                                        style: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 16.sp),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Okay",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                            } } else if (state is VerifyOtpSuccessState) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "OTP Verified successfully!",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 4),
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                              ),
                                            );
                                            CacheData.saveId(data: state.model.userId??0, key: "userId");
                                            CacheData.saveId(data: state.model.userName??"", key: "name");
                                            CacheData.saveId(data: state.model.nationalId??"", key: "nationalId");
                                            CacheData.saveId(data: state.model.phone??"", key: "phone");
                                            print("verify model:${state.model}");
                                            print("phone:${state.model.phone}");
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                            );
                                          } /*else if (state is VerifyOtpSignupRequiredState) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor: Colors.grey[200],
                                                title: Text(
                                                  "Signup Required",
                                                  style: TextStyle(color: primaryColor,fontSize: 18.sp),
                                                ),
                                                content: Text(
                                                  "Your number is not registered. Please sign up to continue.",
                                                  style: TextStyle(color: primaryColor,fontSize: 16.sp),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Close the dialog
                                                      Navigator.pushNamed(
                                                        context,
                                                        SignUpScreen.routeName,
                                                        arguments: state.phone,
                                                      );
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        "Proceed to Sign Up",
                                                        style: TextStyle(color: primaryColor,fontSize: 16.sp),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }*/
                                        }
                                      },
                                      builder: (context, state) {
                                        return InkWell(
                                            onTap: () {
                                              AuthCubit.get(context).verifyOtp(phone:phone,
                                                  otp: code);
                                            },
                                            child: Button(
                                              text: "Confirm",
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Resend OTP code?",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
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
                )
            ],
          );
        },
      ),
    );
  }
}
