import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/features/home%20screen/widgets/custom_speciality.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/speciality_model.dart';

class AllDoctorSpecialtyScreen extends StatelessWidget {
  const AllDoctorSpecialtyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Doctors Speciality", alignment: AlignmentGeometry.center, textAlign: TextAlign.center),
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.kBackGround,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.sp,
            mainAxisExtent: 100.h,
            mainAxisSpacing: 20.h
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
