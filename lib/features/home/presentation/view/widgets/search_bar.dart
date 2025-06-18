import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../l10n/app_localizations.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onClear;
  final ValueChanged<String>? onSearch;

  const SearchBarWidget({required this.controller,
    this.onClear,
    this.onSearch,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            onChanged: onSearch,
            style: TextStyle(
              fontSize: 16.sp,
                fontWeight: FontWeight.w500
            ),
            decoration: InputDecoration(
              hintText: "${AppLocalizations.of(context)!.search}...",
              hintStyle: TextStyle(color: Color(0XFF545454),
                  fontSize: 14.sp, fontWeight: FontWeight.w500),
              filled: true,
              fillColor:Theme.of(context).colorScheme.onBackground,
              prefixIcon: Icon(Icons.search,color:Theme.of(context).colorScheme.primary),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color:Theme.of(context).colorScheme.onBackground,)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color:Theme.of(context).colorScheme.onBackground,)),
              suffixIcon: InkWell(
                  onTap: onClear,
                  child: Icon(Icons.clear, color:Theme.of(context).colorScheme.primary)),
            ),
          ),
        ),
      ],
    );
  }
}
