import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/service/add_service/data/models/category_model.dart';
import 'package:service_app/features/service/add_service/data/models/service_type_model.dart';
import 'package:service_app/features/service/add_service/data/models/sub_category_model.dart';
import 'package:service_app/features/service/add_service/presentation/view/screens/add_service_second_screen.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/category_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/drop_down_container.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/service_type_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/sub_category_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view_model/add_service_cubit.dart';

class AddServiceScreen extends StatefulWidget {
  static const String routeName = "addServiceScreen";

  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => AddServiceScreenState();
}

class AddServiceScreenState extends State<AddServiceScreen> {
  CategoryResult? selectedCategory;
  bool categorySelected = true;
  SubCategoryResult? selectedSubCategory;
  bool categorySubSelected = true;
  ServiceTypeResult? selectedServiceType;
  bool serviceTypeSelected = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Service",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 22.sp),
          ),
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Card(
                  color: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              _showCategorySelectionDialog();
                            },
                            child: DropDownContainer(
                                text:
                                    selectedCategory?.name ?? "Main Category",
                              isLocation: false,)),
                        SizedBox(height: 16.h),
                        InkWell(
                            onTap: () {
                              _showSubCategorySelectionDialog();
                            },
                            child: DropDownContainer(
                                text: selectedSubCategory?.name ??
                                    "Sub Category",isLocation: false,)),
                        SizedBox(height: 16.h),
                        InkWell(
                            onTap: () {
                              _showServiceTypeSelectionDialog();
                            },
                            child: DropDownContainer(
                                text: selectedServiceType?.name ??
                                    "Service Type",isLocation: false,)),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            onConfirm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text("Next",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCategorySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => AddServiceCubit()..getCategories(),
        child: CategoryDialog(
          onCategorySelected: (selectedCategory) {
            setState(() {
              this.selectedCategory = selectedCategory;
              selectedSubCategory = null; // Reset subcategory
              selectedServiceType = null;
            });
          },
        ),
      ),
    );
  }

  void _showSubCategorySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => AddServiceCubit()
          ..getSubCategories(catId: selectedCategory?.id ?? 0),
        child: SubCategoryDialog(
          onSubCategorySelected: (selectedSubCategory) {
            setState(() {
              this.selectedSubCategory = selectedSubCategory;
              selectedServiceType = null;
            });
          },
        ),
      ),
    );
  }

  void _showServiceTypeSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => AddServiceCubit()
          ..getServiceType(subCatId: selectedSubCategory?.id ?? 0),
        child: ServiceTypeDialog(
          onServiceTypeSelected: (selectedServiceType) {
            setState(() {
              this.selectedServiceType = selectedServiceType;
            });
          },
        ),
      ),
    );
  }

  void _validateCategorySelection() {
    setState(() {
      categorySelected =
          selectedCategory?.name != null && selectedCategory!.name!.isNotEmpty;
    });

    if (!categorySelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a category.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _validateSubCategorySelection() {
    setState(() {
      categorySubSelected = selectedSubCategory?.name != null &&
          selectedSubCategory!.name!.isNotEmpty;
    });

    if (!categorySubSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a Sub Category.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _validateServiceTypeSelection() {
    setState(() {
      serviceTypeSelected = selectedServiceType?.name != null &&
          selectedServiceType!.name!.isNotEmpty;
    });

    if (!serviceTypeSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a Service Type.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void onConfirm() {
    final isFormValid = _formKey.currentState!.validate();
    final isCategoryValid = selectedCategory?.name != null && selectedCategory!.name!.isNotEmpty;
    final isSubCategoryValid = selectedSubCategory?.name != null && selectedSubCategory!.name!.isNotEmpty;
    final isServiceTypeValid = selectedServiceType?.name != null && selectedServiceType!.name!.isNotEmpty;

    if (!isCategoryValid) {
      _validateCategorySelection();
    }
    if (!isSubCategoryValid) {
      _validateSubCategorySelection();
    }
    if (!isServiceTypeValid) {
      _validateServiceTypeSelection();
    }

    if (isFormValid && isCategoryValid && isSubCategoryValid && isServiceTypeValid) {
      Navigator.pushNamed(
        context,
        AddServiceSecondScreen.routeName,
        arguments: { 'categoryId': selectedCategory!.id,
          'subCategoryId': selectedSubCategory!.id,
          'serviceTypeId': selectedServiceType!.id,},
      );
    }
  }

}
