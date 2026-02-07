import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/screen_size.dart';
import '../../../shared/custom_text.dart';

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
        horizontal: ScreenSize.screenWidth(context) * 0.03,
        vertical: ScreenSize.screenHeight(context) * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusGeometry.circular(12.r),
          border: isBorder ? Border.all(color: Colors.black) : null,
        ),
        child: ListTile(
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(color: AppColors.kBackGround, borderRadius: BorderRadiusGeometry.circular(12.r)),
            child: Center(child: Icon(icon, color: AppColors.kPrimary)),
          ),
          title: CustomText(text: title, color: AppColors.kGrey, size: 12, alignment: AlignmentGeometry.topLeft),
          subtitle: CustomText(
            text: subTitle,
            color: Colors.black,
            size: 20,
            maxLines: 1,
            alignment: AlignmentGeometry.centerLeft,
          ),
        ),
      ),
    );
  }
}
