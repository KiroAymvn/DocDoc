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
      margin: EdgeInsets.only(bottom: 16.h, left: 20.w, right: 20.w), // مسافات خارجية
      padding: EdgeInsets.all(16.w), // مسافة داخلية للمحتوى
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // === الجزء العلوي: بيانات الطبيب ===
          Row(
            children: [
              // 1. صورة الطبيب
              Container(
                width: 65.w,
                height: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey[200],
                  image: const DecorationImage(image: AssetImage('assets/images/man1.png'), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12.w),

              // 2. النصوص (الاسم والتخصص)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: doctor.name,
                      size: 16,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: doctor.specialization.specialityName,
                      size: 14,
                      color: AppColors.kGrey,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: "${date["dayName"]} , ${date["dayDate"]} ${date["monthName"]}  |  ${date["time"]}",
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGrey,
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),

              // 3. أيقونة المحادثة
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1), // لون خلفية خفيف
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.kPrimary, // أو Colors.blue
                  size: 20.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // === الخط الفاصل ===
          Divider(color: Colors.grey[200], thickness: 1),

          SizedBox(height: 16.h),

          // === الجزء السفلي: الأزرار ===
          Row(
            children: [
              // زر الإلغاء (Border only)
              Expanded(
                child: SizedBox(
                  height: 45.h, // تحديد ارتفاع للزر ليتناسب مع التصميم
                  child: CustomButton(
                    text: "Cancel Appointment",
                    textSize: 12,
                    // تصغير الخط ليتناسب
                    backGroundColor: Colors.transparent,
                    textColor: AppColors.kPrimary,
                    // أو Colors.blue
                    borderColor: AppColors.kPrimary,
                    onTap: () {},
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // زر إعادة الجدولة (Filled)
              Expanded(
                child: SizedBox(
                  height: 45.h,
                  child: CustomButton(
                    text: "Reschedule",
                    textSize: 12,
                    backGroundColor: AppColors.kPrimary,
                    // أو Colors.blue
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
