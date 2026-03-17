import 'package:appointment/features/home%20screen/screens/about_doctor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../core/models/doctor_model.dart';

class CustomDoctorCardWidget extends StatelessWidget {
  const CustomDoctorCardWidget({
    super.key,
    required this.item,
  });

  final DoctorModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutDoctorScreen(doctor: item)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.kCardShadow.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(14.r),
              child: Image.asset(
                "assets/images/man3.png",
                fit: BoxFit.cover,
                width: 90.w,
                height: 90.h,
              ),
            ),
            Gap(14.w),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: item.name,
                    size: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kDarkText,
                    maxLines: 1,
                    alignment: AlignmentGeometry.centerLeft,
                    textAlign: TextAlign.start,
                  ),
                  Gap(4.h),
                  CustomText(
                    text: item.specialization.specialityName,
                    size: 13,
                    maxLines: 1,
                    color: AppColors.kTextMuted,
                  ),
                  Gap(2.h),
                  CustomText(text: item.degree, size: 13, maxLines: 1, color: AppColors.kTextMuted),
                  Gap(6.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomText(
                      text: "${item.appointPrice} LE",
                      color: AppColors.kPrimary,
                      size: 13,
                      fontWeight: FontWeight.w600,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}