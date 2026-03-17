import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constant/app_colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessengerError(
  BuildContext context,
  String? errorMessage, {
  Color? color,
}) {
  final isError = color == null || color == Colors.red;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      elevation: 8,
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              errorMessage!,
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: color ?? AppColors.kError,
    ),
  );
}
