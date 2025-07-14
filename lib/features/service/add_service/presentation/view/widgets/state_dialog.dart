import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/features/service/add_service/data/models/states_model.dart';
import 'package:service_app/features/service/add_service/presentation/view_model/add_service_cubit.dart';
import 'package:service_app/l10n/app_localizations.dart';

class StateDialog extends StatefulWidget{
  final Function(StatesResult states) onStateSelected;
  const StateDialog({super.key,required this.onStateSelected});

  @override
  State<StateDialog> createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {
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
            AppLocalizations.of(context)!.selectState,
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
            if (state is GetStatesLoading) {
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
            } else if (state is GetStatesSuccess) {
              final states =context.read<AddServiceCubit>().states;
              if (states.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/map_3270996.png",width:32.w,height:32.h,),
                      SizedBox(height: 12.h),
                      Text(
                        "No States Found",
                        style: TextStyle(fontSize:20.sp, color: Colors.grey),
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
                itemCount: states.length,
                itemBuilder: (context, index) {
                  final state = states[index];
                  return ListTile(
                    leading: Image.asset("assets/images/map_3270996.png",width: 24.w,height: 24.h,),
                    title: Text(state.stateName ?? "No Name",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onStateSelected(state);
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
