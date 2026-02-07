import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/screen_size.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(5.h),
        Divider(
          indent: ScreenSize.screenWidth(context) / 6,
          endIndent: ScreenSize.screenWidth(context) / 6,
          color: AppColors.kGrey,
        ),
        Gap(5.h),
      ],
    );
  }
}
