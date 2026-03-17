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
    constraints: BoxConstraints(maxHeight: 600.h),
    showDragHandle: true,
    isDismissible: true,
    isScrollControlled: true,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),

    builder: (context) {
      final cubit = context.read<AppointmentCubit>();

      return BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentFailed) {
            Navigator.pop(context);
            scaffoldMessengerError(context, "error happened");
          }
          else if (state is AppointmentSuccess){
            Navigator.pop(context);
            Navigator.pop(context);
            scaffoldMessengerError(context, "Appointment Done Successfully",color: AppColors.kSuccess);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AppointmentCubit>();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Gap(5.h),
                CustomText(
                  text: doctorName,
                  size: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kDarkText,
                  alignment: Alignment.center,
                ),
                CustomDivider(),
                CustomText(text: "Select Date", color: AppColors.kDarkText, fontWeight: FontWeight.w600),
                Gap(8.h),
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
                      child: SizedBox(
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDaySelected ? AppColors.kPrimary : AppColors.kWhite,
                            borderRadius: BorderRadius.all(Radius.circular(14.r)),
                            border: isDaySelected ? null : Border.all(color: AppColors.kBorder),
                            boxShadow: isDaySelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.kPrimary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: dayName,
                                color: isDaySelected ? Colors.white : AppColors.kTextMuted,
                                size: 13,
                                fontWeight: FontWeight.w500,
                                alignment: Alignment.center,
                              ),
                              CustomText(
                                text: date.day.toString(),
                                color: isDaySelected ? Colors.white : AppColors.kDarkText,
                                size: 16,
                                fontWeight: FontWeight.w700,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onDateChange: (date) {
                    print("object");
                    cubit.changeDate(date);
                  },
                ),
                CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          confirmText: "ok",
                        );
                        cubit.changeTime(time ?? TimeOfDay.now());
                      },
                      child: Row(
                        children: [
                          CustomText(text: "Select Time", color: AppColors.kDarkText, fontWeight: FontWeight.w600),
                          SizedBox(width: 6.w),
                          Icon(CupertinoIcons.clock, color: AppColors.kPrimary, size: 20.sp),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CustomText(
                        text: cubit.timeOfDay!.format(context).toString(),
                        color: AppColors.kPrimary,
                        size: 14,
                        fontWeight: FontWeight.w600,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
                CustomDivider(),

                SizedBox(
                  height: 100.h,
                  child: CustomTextFormField(hintText: "Notes", isExpand: true),
                ),
                Gap(12.h),
                state is AppointmentLoading
                    ? Lottie.asset("assets/lottie/Trail_loading.json", height: 50.h)
                    : CustomButton(
                        text: "Book Appointment",
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
              ],
            ),
          );
        },
      );
    },
  );
}
