import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/models/speciality_model.dart';
import '../../../shared/custom_text.dart';

class SpecialityWidget extends StatelessWidget {
  const SpecialityWidget({
    super.key,
    required this.item,
  });

  final SpecialityModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimary.withOpacity(0.12),
                AppColors.kPrimary.withOpacity(0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            item.specialityImage ?? "",
            height: 24.h,
            width: 24.w,
          ),
        ),
        Gap(6.h),
        Flexible(
          child: CustomText(
            text: item.specialityName,
            size: 10,
            maxLines: 1,
            color: AppColors.kDarkText,
            alignment: Alignment.center,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}