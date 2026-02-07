import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../shared/custom_scaffold_messanger.dart';
import '../../appointment/screen/appointment_bottom_model_sheet.dart';
import '../../profile screen/widgets/custom_list_tile.dart';

class AboutDoctorScreen extends StatelessWidget {
  const AboutDoctorScreen({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackGround,
      body: Stack(
        children: [
          // 1. الخلفية العلوية الزرقاء (Top Header Background)
          Container(
            height: 260.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
            ),
          ),

          // 3. المحتوى القابل للتمرير
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 100.h, bottom: 100.h), // مساحة للهيدر والزر السفلي
            child: Column(
              children: [
                // --- بطاقة الطبيب الرئيسية (Floating Card) ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // جسم الكارت الأبيض
                      Container(
                        margin: EdgeInsets.only(top: 50.h), // ترك مساحة للصورة
                        padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: doctor.name,
                              alignment: AlignmentGeometry.center,
                              size: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            Gap(5.h),
                            CustomText(
                              text: "${doctor.specialization.specialityName.substring(0, 2)} - ${doctor.degree}",
                              alignment: AlignmentGeometry.center,
                              size: 18,
                              color: AppColors.kGrey,
                            ),
                            Gap(20.h),
                            // شريط الإحصائيات (Stats Row)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem("Patients", "1.2k+", Colors.blue),
                                _buildDivider(),
                                _buildStatItem("Experience", "5 Years", Colors.orange),
                                _buildDivider(),
                                _buildStatItem("Rating", "4.8", Colors.amber),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // صورة الطبيب (Avatar) تطفو فوق الكارت
                      Positioned(
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55.r,
                            backgroundColor: AppColors.kBackGround,
                            backgroundImage: AssetImage("assets/images/man4.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(25.h),

                // --- قسم "About" ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 5.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Gap(10.w),
                          CustomText(
                            text: "About Doctor",
                            size: 18,
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      Gap(10.h),
                      CustomText(
                        text: doctor.description,
                        size: 14,
                        color: AppColors.kGrey,
                        maxLines: 10,
                        textAlign: TextAlign.start,
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                ),

                Gap(20.h),

                // --- تفاصيل التواصل (List Tiles) ---
                // نستخدم الـ Widget الخاص بك هنا مباشرة
                CustomUserDataListTile(
                  isBorder: true,
                  icon: Icons.access_time_rounded,
                  title: "Working Hours",
                  subTitle: "${doctor.startTime} - ${doctor.endTime}",
                ),

                CustomUserDataListTile(
                  isBorder: true,
                  icon: Icons.location_on_rounded,
                  title: "Location",
                  subTitle: doctor.address,
                ),

                CustomUserDataListTile(
                  isBorder: true,

                  icon: Icons.email_rounded,
                  title: "Contact Email",
                  subTitle: doctor.email,
                ),

                CustomUserDataListTile(
                  isBorder: true,

                  icon: Icons.phone_android_rounded,
                  title: "Phone Number",
                  subTitle: doctor.phone,
                ),

                // مساحة إضافية في الأسفل حتى لا يغطي الزر المحتوى
                Gap(20.h),
              ],
            ),
          ),

          // 4. الشريط السفلي للحجز (Bottom Bar)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              height: 100.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kPrimary),

                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 20, offset: const Offset(0, -5), spreadRadius: -10),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "Total Price", size: 12, color: Colors.grey),
                      Row(
                        children: [
                          CustomText(
                            text: "\$${doctor.appointPrice}",
                            size: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kPrimary,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: CustomText(text: "/session", size: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: ScreenSize.screenWidth(context) / 2,
                    child: BlocConsumer<AppointmentCubit, AppointmentState>(
                      listener: (context, state) {
                      },

                      builder: (context, state) {
                        return CustomButton(
                          text: "Appointment",
                          onTap: () {
                            buildShowModalBottomSheetAppointment(
                              context,
                              state,
                              doctorName: doctor.name,
                              doctorID: doctor.doctorId,
                            );
                          },
                          textSize: 16,
                          backGroundColor: AppColors.kPrimary,
                          textColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(
            label == "Rating"
                ? Icons.star_rounded
                : label == "Patients"
                ? Icons.people_alt_rounded
                : Icons.verified_rounded,
            color: color,
            size: 20.sp,
          ),
        ),
        Gap(8.h),
        CustomText(text: value, size: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        CustomText(text: label, size: 12, color: Colors.grey),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 40.h, width: 1.w, color: Colors.grey.withOpacity(0.2));
  }
}
