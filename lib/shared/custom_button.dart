import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.onTap,
    this.backGroundColor = AppColors.kPrimary,
    this.borderColor,
    this.useGradient = false,
  });

  final String text;
  final Color? backGroundColor;
  final Color? textColor;
  Color? borderColor;
  double? textSize;
  final void Function()? onTap;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 250.w,
        height: 52.h,
        decoration: BoxDecoration(
          gradient: (useGradient && borderColor == null)
              ? const LinearGradient(
                  colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: (useGradient && borderColor == null) ? null : backGroundColor,
          borderRadius: BorderRadius.all(Radius.circular(14.r)),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1.5.w)
              : Border.all(color: Colors.transparent),
          boxShadow: (backGroundColor != Colors.transparent &&
                  backGroundColor != Colors.white &&
                  borderColor == null)
              ? [
                  BoxShadow(
                    color: (backGroundColor ?? AppColors.kPrimary).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: textSize?.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
