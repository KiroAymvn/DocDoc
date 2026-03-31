import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_scaffold_messanger.dart';
import 'package:appointment/shared/custom_text_form_field.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../data/presentation/appointment_cubit.dart';
import '../widget/custom_divider.dart';

Future<dynamic> buildShowModalBottomSheetAppointment(
  BuildContext context,
  AppointmentState state, {
  required String doctorName,
  required int doctorID,
}) {
  return showModalBottomSheet(
    backgroundColor: AppColors.kSurface,
    context: context,
    sheetAnimationStyle: AnimationStyle(curve: SawTooth(3), duration: Duration(seconds: 1), reverseCurve: SawTooth(1)),
    showDragHandle: false,
    isDismissible: true,
    isScrollControlled: true,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
    ),
    builder: (context) {
      final cubit = context.read<AppointmentCubit>();

      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 650.h),
          child: BlocConsumer<AppointmentCubit, AppointmentState>(
            listener: (context, state) {
              if (state is AppointmentFailed) {
                Navigator.pop(context);
                scaffoldMessengerError(context, "error happened");
              } else if (state is AppointmentSuccess) {
                Navigator.pop(context);
                Navigator.pop(context);
                scaffoldMessengerError(context, "Appointment Done Successfully", color: AppColors.kSuccess);
              }
            },
            builder: (context, state) {
              final cubit = context.read<AppointmentCubit>();

              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // ── Header ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 18.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      // drag handle
                      Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Icon(CupertinoIcons.calendar_today, color: Colors.white, size: 22.sp),
                          ),
                          Gap(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Book Appointment",
                                  size: 11,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  alignment: Alignment.centerLeft,
                                ),
                                Gap(2.h),
                                CustomText(
                                  text: doctorName,
                                  size: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Scrollable body ──────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Section label: Date ──────────────────────
                        _SectionLabel(
                          icon: CupertinoIcons.calendar,
                          label: "Select Date",
                        ),
                        Gap(12.h),

                        // ── Date Picker ──────────────────────────────
                        EasyDateTimeLinePicker.itemBuilder(
                          controller: cubit.controller,
                          focusedDate: cubit.dateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030, 3, 18),
                          itemExtent: 60.w,
                          currentDate: DateTime.now(),
                          itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
                            final String dayName = DateFormat("EEE").format(date);

                            bool isDaySelected =
                                date.year == cubit.dateTime?.year &&
                                date.month == cubit.dateTime?.month &&
                                date.day == cubit.dateTime?.day;

                            return GestureDetector(
                              onTap: () {
                                cubit.changeDate(date);
                                print(date);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  gradient: isDaySelected
                                      ? const LinearGradient(
                                          colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: isDaySelected ? null : AppColors.kWhite,
                                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                                  border: isDaySelected ? null : Border.all(color: AppColors.kBorder),
                                  boxShadow: isDaySelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.kPrimary.withOpacity(0.35),
                                            blurRadius: 12,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.03),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: dayName,
                                      color: isDaySelected ? Colors.white.withOpacity(0.85) : AppColors.kTextMuted,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                      alignment: Alignment.center,
                                    ),
                                    CustomText(
                                      text: date.day.toString(),
                                      color: isDaySelected ? Colors.white : AppColors.kDarkText,
                                      size: 17,
                                      fontWeight: FontWeight.w700,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onDateChange: (date) {
                            print("object");
                            cubit.changeDate(date);
                          },
                        ),

                        Gap(20.h),

                        // ── Section label: Time ──────────────────────
                        _SectionLabel(
                          icon: CupertinoIcons.clock,
                          label: "Select Time",
                        ),
                        Gap(12.h),

                        // ── Time Picker Row ──────────────────────────
                        GestureDetector(
                          onTap: () async {
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              confirmText: "ok",
                            );
                            cubit.changeTime(time ?? TimeOfDay.now());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.kBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(CupertinoIcons.clock_fill, color: AppColors.kPrimary, size: 18.sp),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: CustomText(
                                    text: "Tap to change time",
                                    size: 13,
                                    color: AppColors.kTextMuted,
                                    fontWeight: FontWeight.w400,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.kPrimary.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: CustomText(
                                    text: cubit.timeOfDay!.format(context).toString(),
                                    color: Colors.white,
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Gap(20.h),

                        // ── Section label: Notes ─────────────────────
                        _SectionLabel(
                          icon: CupertinoIcons.pencil_ellipsis_rectangle,
                          label: "Notes  (optional)",
                        ),
                        Gap(12.h),

                        // ── Notes Field ──────────────────────────────
                        Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CustomTextFormField(
                            hintText: "Add any notes for the doctor...",
                            isExpand: true,
                            controller: context.read<AppointmentCubit>().notesController,
                          ),
                        ),

                        Gap(24.h),

                        // ── Book Button ──────────────────────────────
                        state is AppointmentLoading
                            ? Center(child: Lottie.asset("assets/lottie/Trail_loading.json", height: 56.h))
                            : SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  text: "Book Appointment",
                                  useGradient: true,
                                  onTap: () {
                                    final String time = cubit.formatTime24H(cubit.timeOfDay ?? TimeOfDay.now());
                                    final String appointmentTime = "${cubit.dateTime.toString().substring(0, 10)} $time";
                                    print(appointmentTime);
                                    cubit.postAppointment(
                                      doctorId: doctorID.toString(),
                                      startDate: appointmentTime,
                                      notes: cubit.notesController.text,
                                      context: context,
                                    );
                                  },
                                ),
                              ),
                        Gap(16.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
    },
  );
}

// ── Small section-label helper (UI only) ──────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.kPrimary, size: 16.sp),
        Gap(6.w),
        CustomText(
          text: label,
          size: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.kDarkText,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
