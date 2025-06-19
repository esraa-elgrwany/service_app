import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:service_app/core/cache/shared_preferences.dart';
import 'package:service_app/features/auth/presentation/view/widgets/header.dart';
import 'package:service_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/text_form_widget.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../home/presentation/view/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "SignUpScreen";
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      phoneController.text = args;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool isLoading = state is SignUpLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Sign Up',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 22.sp),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Header("Sign up", "Create new account"),
                          SizedBox(height: 20.h),
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
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
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                TextFormWidget(
                                    controller: phoneController,
                                    hint:phoneController.text,
                                    icon: Icons.call,
                                    readOnly: true,
                                    maxLine: 1,
                                    validateTxt:
                                        "please enter your phone number"),
                                Text("name",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: 8.h),
                                TextFormWidget(
                                    controller: userController,
                                    hint: "name",
                                    icon: Icons.person,
                                    readOnly: false,
                                    maxLine: 1,
                                    validateTxt: "please enter your username"),
                                SizedBox(height: 16.h),
                                Text("ID number",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: 8.h),
                                TextFormWidget(
                                    controller: idController,
                                    hint: "id number",
                                    icon: Icons.numbers,readOnly:false,
                                    maxLine: 1,
                                    validateTxt: "please enter your id number"),
                                SizedBox(height: 16.h),
                                Text("ID expiry date",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: 8.h),
                                GestureDetector(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      selectedDate = picked;
                                      dateController.text =
                                          DateFormat.yMd().format(picked);
                                      setState(() {});
                                    }
                                  },
                                  child: AbsorbPointer(
                                      child: TextFormWidget(
                                        readOnly: false,
                                          controller: dateController,
                                          hint: 'id expiry date',
                                          validateTxt: "required",
                                          maxLine: 1,
                                          icon: Icons.date_range_outlined)),
                                ),
                                SizedBox(height: 16.h),
                                Text("address",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: 8.h),
                                TextFormWidget(
                                    controller: addressController,
                                    hint: "address",
                                    icon: Icons.location_on_outlined,
                                    readOnly: false,
                                    maxLine: 1,
                                    validateTxt: "please enter your address"),
                                SizedBox(height: 30.h),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is SignUpErrorState) {
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
                                            state.errorMessage,
                                            style:
                                                TextStyle(color: primaryColor,fontSize: 16.sp),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Okay",
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (state is SignUpSuccessState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Registered successfully!",
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
                                              vertical: 12, horizontal: 4),
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
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
                                              if (formKey.currentState!
                                                  .validate()) {
                                                if (selectedDate == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Please select expiry date'),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                context
                                                    .read<AuthCubit>()
                                                    .register(
                                                      phone: phoneController
                                                          .text
                                                          .trim(),
                                                      name: userController.text
                                                          .trim(),
                                                      nationalId: idController
                                                          .text
                                                          .trim(),
                                                      nationalIdExpiry:
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  selectedDate!),
                                                      address: addressController
                                                          .text
                                                          .trim(),
                                                    );
                                              }
                                            },
                                            child: Text(
                                              "Sign up",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0XFF1d194a),
                                              padding: EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(12)),
                                              textStyle: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ],
                      ),
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
