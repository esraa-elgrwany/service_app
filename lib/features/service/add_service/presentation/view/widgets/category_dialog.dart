import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/features/service/add_service/data/models/category_model.dart';
import 'package:service_app/features/service/add_service/presentation/view_model/add_service_cubit.dart';

class CategoryDialog extends StatefulWidget{
  final Function(CategoryResult category) onCategorySelected;
  const CategoryDialog({super.key,required this.onCategorySelected});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
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
                  context.read<AddServiceCubit>().getC(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search Status...",
                border: InputBorder.none,
              ),
            ),
          )
              : */
          Text(
           " Select Category",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          /*IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getStatus();
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
            if (state is GetCategoriesLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetCategoriesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
                    SizedBox(height: 12),
                    Text(
                      "An error occurred.",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              );
            } else if (state is GetCategoriesSuccess) {
              final cat =context.read<AddServiceCubit>().categories;
              if (cat.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/categories_6521775.png",width: 32.w,height: 32.h,),
                      SizedBox(height: 12.h),
                      Text(
                        "No Categories Found",
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
                itemCount: cat.length,
                itemBuilder: (context, index) {
                  final categoryItem = cat[index];
                  return ListTile(
                    leading: Image.asset("assets/images/categories_6521775.png",width: 24.w,height: 24.h,),
                    title: Text(categoryItem.name ?? "No Name",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onCategorySelected(categoryItem);
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