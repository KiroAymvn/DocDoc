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
    return SizedBox(
      height: 80.h, // 🔥 مهم جدًا
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.kPrimary.withOpacity(0.25),
            radius: 28.r,
            child: Image.asset(
              item.specialityImage ?? "",
              height: 28.h,
            ),
          ),
          Gap(6.h),
          CustomText(
            text: item.specialityName,
            size: 10,
            maxLines: 1, // 🔥
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
