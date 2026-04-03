import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/features/favorites/data/presentation/favorites_cubit.dart';
import 'package:appointment/shared/custom_scaffold_messanger.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../appointment/screen/appointment_bottom_model_sheet.dart';

class AboutDoctorScreen extends StatefulWidget {
  const AboutDoctorScreen({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  State<AboutDoctorScreen> createState() => _AboutDoctorScreenState();
}

class _AboutDoctorScreenState extends State<AboutDoctorScreen> {
  @override
  void initState() {
    context.read<AppointmentCubit>().notesController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // A clean, off-white background is more modern than pure white
    final Color kBackgroundColor = const Color(0xFFFAFAFA);
    final Color kSurfaceColor = Colors.white;
    final Color kBorderColor = Colors.grey.withOpacity(0.15);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // --- 1. Background Header Image/Gradient ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Container(
              color: AppColors.kPrimary.withOpacity(0.08), // Very subtle tint
              child: Stack(
                children: [
                  // Decorative circle 1
                  Positioned(
                    top: -50,
                    right: -50,
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: AppColors.kPrimary.withOpacity(0.1),
                    ),
                  ),
                  // Decorative circle 2
                  Positioned(
                    bottom: 50,
                    left: -30,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.kPrimary.withOpacity(0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 2. Custom App Bar ---
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGlassButton(
                  context,
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.pop(context),
                ),
                CustomText(
                  text: "Doctor Profile",
                  size: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                // Favorite toggle button — reads FavoritesCubit state
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favState) {
                    final isFav = context
                        .read<FavoritesCubit>()
                        .isFavorite(widget.doctor.doctorId);
                    return _buildGlassButton(
                      context,
                      icon: isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconColor: isFav ? Colors.red : Colors.black87,
                      onTap: () async {
                        final wasAdded = await context
                            .read<FavoritesCubit>()
                            .toggleFavorite(widget.doctor);
                        scaffoldMessengerError(
                          context,
                          wasAdded
                              ? '${widget.doctor.name} added to favorites ❤️'
                              : '${widget.doctor.name} removed from favorites',
                          color: wasAdded
                              ? AppColors.kPrimary
                              : AppColors.kError,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // --- 3. Scrollable Content ---
          Positioned.fill(
            top: 100.h,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 20.h,
                bottom: 120.h,
              ), // Space for bottom bar
              child: Column(
                children: [
                  // --- Profile Section (Center) ---
                  Center(
                    child: Column(
                      children: [
                        // Avatar with "Online" Status and Sharp Border
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.kPrimary,
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                              child: CircleAvatar(
                                radius: 65.r,
                                backgroundImage: const AssetImage(
                                  "assets/images/man2.png",
                                ),
                                backgroundColor: Colors.grey.shade200,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(15.h),
                        CustomText(
                          text: widget.doctor.name,
                          size: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          textAlign: .center,
                          alignment: AlignmentGeometry.center,
                        ),
                        Gap(5.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomText(
                            text: widget.doctor.specialization.specialityName,
                            size: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimary,
                            alignment: AlignmentGeometry.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(30.h),

                  // --- Stats Grid (Sharp & Clean) ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: kSurfaceColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: kBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("Patients", "1.2k+", Colors.blue),
                          Container(
                            width: 1,
                            height: 40.h,
                            color: kBorderColor,
                          ),
                          _buildStatItem("Experience", "5 Yr", Colors.orange),
                          Container(
                            width: 1,
                            height: 40.h,
                            color: kBorderColor,
                          ),
                          _buildStatItem("Rating", "4.8", Colors.amber),
                        ],
                      ),
                    ),
                  ),

                  Gap(25.h),

                  // --- About Section ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "About Doctor",
                          size: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        Gap(10.h),
                        CustomText(
                          text: widget.doctor.description,
                          size: 14,
                          color: Colors.grey.shade600,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),

                  Gap(25.h),

                  // --- Info List (Modern Tiles) ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          icon: Icons.access_time_filled_rounded,
                          color: Colors.blue.shade100,
                          iconColor: Colors.blue,
                          title: "Working Hours",
                          subtitle:
                              "${widget.doctor.startTime} - ${widget.doctor.endTime}",
                        ),
                        Gap(15.h),
                        _buildInfoTile(
                          icon: Icons.location_on_rounded,
                          color: Colors.red.shade100,
                          iconColor: Colors.red,
                          title: "Location",
                          subtitle: widget.doctor.address,
                        ),
                        Gap(15.h),
                        _buildInfoTile(
                          icon: Icons.phone_in_talk_rounded,
                          color: Colors.green.shade100,
                          iconColor: Colors.green,
                          title: "Contact",
                          subtitle: widget.doctor.phone,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 4. Floating Bottom Action Bar ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(24.w),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: kBorderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Price Tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Price", size: 12, color: Colors.grey),
                        CustomText(
                          text: "\$${widget.doctor.appointPrice}",
                          size: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),

                  Gap(16.w),

                  // Appointment Button
                  Expanded(
                    child: BlocConsumer<AppointmentCubit, AppointmentState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return SizedBox(
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () {
                              buildShowModalBottomSheetAppointment(
                                context,
                                state,
                                doctorName: widget.doctor.name,
                                doctorID: widget.doctor.doctorId,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.kPrimary,
                              elevation: 0, // Flat look is sharper
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: CustomText(
                              text: "Appointment",
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              alignment: Alignment.center,
                            ),
                          ),
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

  // --- Helper Widgets for Sharp UI ---
  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: iconColor, size: 20.sp),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: value,
          size: 20,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
          alignment: Alignment.center,
        ),
        Gap(4.h),
        CustomText(
          text: label,
          size: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade500,
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  size: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                Gap(2.h),
                CustomText(
                  text: subtitle,
                  size: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
