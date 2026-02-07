import 'package:appointment/core/constant/screen_size.dart';
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

     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => AboutDoctorScreen(doctor: item),));
     },
      child: Padding(
        padding:  EdgeInsets.all(8.0.sp),
        child: SizedBox(
          width: double.infinity,
          height: 90.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12.r),
                child: Image.asset("assets/images/man3.png",fit: BoxFit.cover,width: 100.w,),
              ),
              Gap(ScreenSize.screenWidth(context)*0.05),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: item.name,
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      maxLines: 1,
                      alignment: AlignmentGeometry.centerLeft,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: item.specialization.specialityName,
                      size: 14,
                      maxLines: 1,
                      color: AppColors.kGrey,
                    ),
                    CustomText(text: item.degree, size: 14, maxLines: 1, color: AppColors.kGrey),
                    CustomText(
                      text: "${item.appointPrice} LE",
                      size: 14,
                      maxLines: 1,
                      color: AppColors.kGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
