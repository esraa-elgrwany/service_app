import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/features/service/add_service/data/models/government_model.dart';
import 'package:service_app/features/service/add_service/presentation/view_model/add_service_cubit.dart';
import 'package:service_app/l10n/app_localizations.dart';

class GovernDialog extends StatefulWidget{
  final Function(GovernmentResult government) onGovernmentSelected;
  const GovernDialog({super.key,required this.onGovernmentSelected});

  @override
  State<GovernDialog> createState() => _GovernDialogState();
}

class _GovernDialogState extends State<GovernDialog> {
  /* bool isSearching = false;
  TextEditingController searchController = TextEditingController();*/
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /* isSearching
              ? Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                if (searchController.text.isNotEmpty) {
                  context.read<HomeCubit>().getStates(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search States...",
                border: InputBorder.none,
              ),
            ),
          )
              : */
          Text(
            AppLocalizations.of(context)!.selectGovern,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          /* IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getStates();
                }
              });
            },
          ),*/
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.6,
        child: BlocBuilder<AddServiceCubit, AddServiceState>(
          builder: (context, state) {
            if (state is GetGovernmentsLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetStatesError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50.sp),
                    SizedBox(height: 12.h),
                    Text(
                      "An error occurred.",
                      style: TextStyle(color: Colors.red, fontSize: 20.sp),
                    ),
                  ],
                ),
              );
            } else if (state is GetGovernmentsSuccess) {
              final government =context.read<AddServiceCubit>().governments;
              if (government.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/government_15624646.png",width:32.w,height:32.h,),
                      SizedBox(height: 12.h),
                      Text(
                        "No Governments Found",
                        style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1,
                  endIndent: 8,
                  indent: 8,
                ),
                itemCount: government.length,
                itemBuilder: (context, index) {
                  final govern = government[index];
                  return ListTile(
                    leading: Image.asset("assets/images/government_15624646.png",width: 24.w,height: 24.h,),
                    title: Text(govern.governmentName ?? "No Name",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onGovernmentSelected(govern);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
            return SizedBox(); // Default empty state
          },
        ),
      ),
    );
  }
}