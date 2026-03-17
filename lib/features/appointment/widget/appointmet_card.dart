import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';
import 'package:appointment/features/appointment/data/model/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({super.key, required this.appointmentModel});

  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> date = DateHelper.extractDateData(appointmentModel.appointmentTime);

    final DoctorModel doctor = appointmentModel.doctor;
    final String notes = appointmentModel.notes;
    return Container(
      margin: EdgeInsets.only(bottom: 14.h, left: 16.w, right: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.kBorder.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.kCardShadow.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top section: doctor info
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.kLightGrey,
                  image: const DecorationImage(image: AssetImage('assets/images/man1.png'), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: doctor.name,
                      size: 16,
                      fontWeight: FontWeight.w700,
                      alignment: Alignment.centerLeft,
                      color: AppColors.kDarkText,
                    ),
                    SizedBox(height: 3.h),
                    CustomText(
                      text: doctor.specialization.specialityName,
                      size: 13,
                      color: AppColors.kTextMuted,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 14.sp, color: AppColors.kPrimary),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: CustomText(
                            text: "${date["dayName"]} , ${date["dayDate"]} ${date["monthName"]}  |  ${date["time"]}",
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kGrey,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.kPrimary,
                  size: 18.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Divider
          Divider(color: AppColors.kBorder, thickness: 1),

          SizedBox(height: 14.h),

          // Bottom: Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: CustomButton(
                    text: "Cancel",
                    textSize: 13,
                    backGroundColor: Colors.transparent,
                    textColor: AppColors.kPrimary,
                    borderColor: AppColors.kBorder,
                    onTap: () {},
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: CustomButton(
                    text: "Reschedule",
                    textSize: 13,
                    backGroundColor: AppColors.kPrimary,
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
