import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:service_app/core/utils/styles/colors.dart';
import 'package:service_app/features/service/add_service/data/models/government_model.dart';
import 'package:service_app/features/service/add_service/data/models/states_model.dart';
import 'package:service_app/features/service/add_service/data/models/village_model.dart';
import 'package:service_app/features/service/add_service/presentation/view/screens/map_picker_screen.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/drop_down_container.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/govern_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/state_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/text_form_widget.dart';
import 'package:service_app/features/service/add_service/presentation/view/widgets/village_dialog.dart';
import 'package:service_app/features/service/add_service/presentation/view_model/add_service_cubit.dart';

import '../../../../../../core/cache/shared_preferences.dart';
import '../../../data/models/get_fields_model.dart';

class AddServiceSecondScreen extends StatefulWidget {
  static const String routeName = "addServiceSecondScreen";

  const AddServiceSecondScreen({super.key});

  @override
  State<AddServiceSecondScreen> createState() => _AddServiceSecondScreenState();
}

class _AddServiceSecondScreenState extends State<AddServiceSecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GovernmentResult? selectedGovernment;
  bool governmentSelected = true;
  StatesResult? selectedState;
  bool stateSelected = true;
  VillageResult? selectedVillage;
  bool villageSelected = true;

  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? fromDate;
  String? toDate;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
   String? location;
  PlatformFile? uploadedFile;

  @override
  void initState() {
    super.initState();
    _loadCachedUserData();
  }

  void _loadCachedUserData() async {
    nameController.text = await CacheData.getData(key: "name") ?? "";
    _phoneController.text = await CacheData.getData(key: "phone") ?? "";
    idController.text = await CacheData.getData(key: "nationalId") ?? "";
    setState(() {}); // Update UI after async
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final int categoryId = args['categoryId'];
    final int subCategoryId = args['subCategoryId'];
    final int serviceTypeId = args['serviceTypeId'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Service",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => AddServiceCubit()
          ..getFields(serviceId: serviceTypeId)
          ..getDocument(serviceId: serviceTypeId)
          ..getUser(),
        child: BlocBuilder<AddServiceCubit, AddServiceState>(
          builder: (context, state) {
            final documents = context.read<AddServiceCubit>().document;
            final fields = context.read<AddServiceCubit>().fields;
            final user = context.read<AddServiceCubit>().user;
            if (fields.length < 7) {
              return const Center(child: CircularProgressIndicator());
            }
            bool isLoading = state is SubmitServiceLoading;
            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Card(
                          color: Theme.of(context).colorScheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormWidget(
                                  controller: nameController,
                                  hint: user.userName ?? "",
                                  maxLine: 1,
                                  icon: Icons.person,
                                  readOnly: true,
                                  validateTxt: "Required",
                                ),
                                SizedBox(height: 16.h),
                                TextFormWidget(
                                  controller: idController,
                                  hint: user.nationalId ?? "",
                                  maxLine: 1,
                                  readOnly: true,
                                  icon: Icons.card_membership,
                                  validateTxt: "Required",
                                ),
                                SizedBox(height: 16.h),
                                TextFormWidget(
                                  controller: _phoneController,
                                  hint: user.phone ?? "",
                                  icon: Icons.phone,
                                  validateTxt: "Required",
                                  maxLine: 1,
                                  readOnly: true,
                                ),
                                SizedBox(height: 16.h),
                                TextFormWidget(
                                  controller: _descriptionController,
                                  hint: "Description",
                                  maxLine: 3,
                                  readOnly: false,
                                  icon: Icons.description,
                                  validateTxt: "Required",
                                ),
                                SizedBox(height: 16.h),
                                if (fields[1].status != "no")
                                  InkWell(
                                    onTap: () =>
                                        _showGovernmentSelectionDialog(),
                                    child: DropDownContainer(
                                      text:
                                          selectedGovernment?.governmentName ??
                                              "Government",
                                      isLocation: false,
                                    ),
                                  ),
                                if (fields[1].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields[0].status != "no")
                                  InkWell(
                                    onTap: () => _showStateSelectionDialog(),
                                    child: DropDownContainer(
                                      text: selectedState?.stateName ?? "State",
                                      isLocation: false,
                                    ),
                                  ),
                                if (fields[0].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields[2].status != "no")
                                  InkWell(
                                    onTap: () => _showVillageSelectionDialog(),
                                    child: DropDownContainer(
                                      text: selectedVillage?.villageName ??
                                          "Village",
                                      isLocation: false,
                                    ),
                                  ),
                                if (fields[2].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields[3].status != "no")
                                  TextFormWidget(
                                    controller: referenceController,
                                    hint: "Reference",
                                    readOnly: false,
                                    maxLine: 1,
                                    icon: Icons.text_fields_rounded,
                                    validateTxt:
                                        (fields[3].status == "required")
                                            ? "Required"
                                            : "",
                                  ),
                                if (fields[3].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields[4].status != "no")
                                  buildDatePickerField("From Date", fromDate,
                                      () => _selectFromDate(context)),
                                if (fields[4].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields[5].status != "no")
                                  buildDatePickerField("To Date", toDate,
                                      () => _selectToDate(context)),
                                if (fields[5].status != "no")
                                  SizedBox(height: 16.h),
                                if (fields.last.status != "no")
                                  InkWell(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MapPickerScreen()),
                                      );
                                      if (result != null &&
                                          result['address'] != null) {
                                        setState(() {
                                          location =
                                              result['address'];
                                        });
                                      }
                                    },
                                    child: DropDownContainer(
                                      text:location==null?"Location":location??"no location",
                                      isLocation: true,
                                    ),
                                  ),
                                if (fields.last.status != "no")
                                  SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/binder_11357863.png",
                                      width: 28.w,
                                      height: 28.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Required documents:",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                if (documents.isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      final doc = documents[index];
                                      return Row(
                                        children: [
                                          Icon(
                                            Icons.file_copy_outlined,
                                            size: 24.sp,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            doc.name ?? "Unnamed Document",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                else
                                  const Text("No documents found."),
                                SizedBox(height: 16.h),
                                ElevatedButton.icon(
                                  onPressed: _pickFile,
                                  icon: Icon(Icons.upload_file,
                                      color: primaryColor),
                                  label: Text(
                                    "Upload File",
                                    style: GoogleFonts.montserrat(
                                      color: primaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondPrimary,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: primaryColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                                if (uploadedFile != null)
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Row(
                                      children: [
                                        Icon(Icons.insert_drive_file,
                                            size: 24.sp, color: primaryColor),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            uploadedFile!.name,
                                            style: TextStyle(fontSize: 14.sp),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 16.h),
                                BlocConsumer<AddServiceCubit, AddServiceState>(
                                  listener: (context, state) {
                                    if (state is SubmitServiceError) {
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
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16.sp),
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
                                    } else if (state is SubmitServiceSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                              "Submit Service Request successfully!",
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
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        final fieldsData = <String, dynamic>{};

                                        if (fields[1].status != "no" &&
                                            selectedGovernment != null) {
                                          fieldsData["government_id"] =
                                              selectedGovernment!.id;
                                        }

                                        if (fields[0].status != "no" &&
                                            selectedState != null) {
                                          fieldsData["state_id"] =
                                              selectedState!.id;
                                        }
                                        if (fields[2].status != "no" &&
                                            selectedVillage != null) {
                                          fieldsData["village_name_id"] =
                                              selectedVillage!.id;
                                        }
                                        if (fields.last.status != "no") {
                                          fieldsData["location"] =
                                              location;
                                        }
                                        if (fields[3].status != "no") {
                                          fieldsData["reference"] =
                                              referenceController.text;
                                        }
                                        if (fields[4].status != "no" &&
                                            fromDate != null) {
                                          fieldsData["from_date"] = fromDate;
                                        }

                                        if (fields[5].status != "no" &&
                                            toDate != null) {
                                          fieldsData["to_date"] = toDate;
                                        }
                                        print("fields data:$fieldsData");
                                        print("categoryId:$categoryId");
                                        print("subCategoryId:$subCategoryId");
                                        print("serviceTypeId:$serviceTypeId");
                                        print("from date$fromDate");
                                        print("from date$toDate");
                                        if (_formKey.currentState!.validate() &&
                                            validateDynamicFields(fields)) {
                                          AddServiceCubit.get(context)
                                              .submitService(
                                            categoryId: categoryId,
                                            subCategoryId: subCategoryId,
                                            serviceTypeId: serviceTypeId,
                                            description:
                                                _descriptionController.text,
                                            fieldsData: fieldsData,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        "Submit Request",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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
      ),
    );
  }

  void _showGovernmentSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => AddServiceCubit()..getGovernments(),
        child: GovernDialog(
          onGovernmentSelected: (selectedGovernment) {
            setState(() {
              this.selectedGovernment = selectedGovernment;
            });
          },
        ),
      ),
    );
  }

  void _showStateSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            AddServiceCubit()..getStates(governId: selectedGovernment?.id ?? 0),
        child: StateDialog(
          onStateSelected: (selectedState) {
            setState(() {
              this.selectedState = selectedState;
            });
          },
        ),
      ),
    );
  }

  void _showVillageSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            AddServiceCubit()..getVillage(stateId: selectedState?.id ?? 0),
        child: VillageDialog(
          onVillageSelected: (selectedVillage) {
            setState(() {
              this.selectedVillage = selectedVillage;
            });
          },
        ),
      ),
    );
  }

  bool validateDynamicFields(List<Fields> fields) {
    if (fields[1].status == "required" && selectedGovernment == null) {
      showSnackBar("Government is required");
      return false;
    }
    if (fields[0].status == "required" && selectedState == null) {
      showSnackBar("State is required");
      return false;
    }
    if (fields[2].status == "required" && selectedVillage == null) {
      showSnackBar("Village is required");
      return false;
    }
    if (fields[3].status == "required" && referenceController.text.isEmpty) {
      showSnackBar("Reference is required");
      return false;
    }
    if (fields[4].status == "required" && fromDate == null) {
      showSnackBar("From Date is required");
      return false;
    }
    if (fields[5].status == "required" && toDate == null) {
      showSnackBar("To Date is required");
      return false;
    }
    if (fields.last.status == "required" && location==null) {
      showSnackBar("Location is required");
      return false;
    }

    return true;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          uploadedFile = result.files.first;
        });

        debugPrint("File Name: ${uploadedFile!.name}");
        debugPrint("File Path: ${uploadedFile!.path}");
      } else {
        debugPrint("User canceled file picker.");
      }
    } catch (e) {
      debugPrint("File picker error: $e");
    }
  }

  Widget buildDatePickerField(String label, String? value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Icon(
              Icons.date_range,
              color: primaryColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedFromDate = picked;
      fromDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedToDate = picked;
      toDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }
}
