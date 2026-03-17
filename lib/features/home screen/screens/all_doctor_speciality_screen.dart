import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/features/home%20screen/widgets/custom_speciality.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';

import '../../../core/models/speciality_model.dart';

class AllDoctorSpecialtyScreen extends StatelessWidget {
  const AllDoctorSpecialtyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Doctors Speciality",
          size: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kDarkText,
          alignment: Alignment.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.sp,
            mainAxisExtent: 110.h,
            mainAxisSpacing: 12.h,
          ),
          itemBuilder: (context, index) {
            final item = SpecialityModel.specialityList[index];
            return SpecialityWidget(item: item);
          },
          itemCount: SpecialityModel.specialityList.length,
        ),
      ),
    );
  }
}
