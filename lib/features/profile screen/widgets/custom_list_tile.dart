import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/screen_size.dart';

class CustomUserDataListTile extends StatelessWidget {
  CustomUserDataListTile({
    super.key,
    required this.icon,
    this.isBorder = false,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  bool isBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.screenWidth(context) * 0.04,
        vertical: 6.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusGeometry.circular(14.r),
          border: isBorder ? Border.all(color: AppColors.kBorder) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.kPrimary.withOpacity(0.12),
                  AppColors.kPrimary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadiusGeometry.circular(12.r),
            ),
            child: Center(child: Icon(icon, color: AppColors.kPrimary, size: 22.sp)),
          ),
          title: CustomText(
            text: title,
            color: AppColors.kTextMuted,
            size: 12,
            fontWeight: FontWeight.w400,
          ),
          subtitle: CustomText(
            text: subTitle,
            color: AppColors.kDarkText,
            size: 16,
            fontWeight: FontWeight.w600,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
