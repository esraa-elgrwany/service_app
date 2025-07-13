import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/api_services/api-manager.dart';
import '../../../../../core/utils/constants.dart';

class OdooImage extends StatelessWidget{
  final String url;
  final double? height, width;
  final BoxFit fit;

  const OdooImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getSessionId(),
      builder: (context, snapshot) {
        // While loading cookie → small grey placeholder
        if (!snapshot.hasData) {
          return Container(
            height: height,
            width: width,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 2),
          );
        }

        final cookie = snapshot.data;
        return Image.network(
          url,
          height: height,
          width: width,
          fit: fit,
          headers: cookie != null ? {"Cookie": "session_id=$cookie"} : null,
          errorBuilder: (ctx, err, stack) => _errorPlaceholder(),
        );
      },
    );
  }

  Future<String?> _getSessionId() async {
    final uri = Uri.parse(Constants.baseUrl);
    final cookies = await ApiManager().cookieJar.loadForRequest(uri);
    final session = cookies.firstWhere(
          (c) => c.name == 'session_id',
      orElse: () => Cookie('', ''),
    );
    return session.value.isEmpty ? null : session.value;
  }

  Widget _errorPlaceholder() => Container(
    height: height,
    width: width,
    color: Colors.grey.shade400,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.broken_image, size: 48.sp, color: Colors.black),
        SizedBox(height: 8.h),
        Text("Image failed to load",
            style: TextStyle(fontSize: 14.sp, color: Colors.black)),
      ],
    ),
  );
}
