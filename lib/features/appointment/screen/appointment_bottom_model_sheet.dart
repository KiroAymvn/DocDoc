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
  // لا حاجة لتمرير state هنا
  return showModalBottomSheet(
    backgroundColor: AppColors.kBackGround,
    context: context,
    sheetAnimationStyle: AnimationStyle(curve: SawTooth(3), duration: Duration(seconds: 1), reverseCurve: SawTooth(1)),
    constraints: BoxConstraints(maxHeight: 600.h),
    showDragHandle: true,
    isDismissible: true,
    isScrollControlled: true,
    useRootNavigator: true,

    builder: (context) {
      final cubit = context.read<AppointmentCubit>();

      // استخدم context جديد هنا لتجنب التداخل
      // 1. Wrap with BlocBuilder to listen for changes
      return BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentFailed) {
            Navigator.pop(context);
            scaffoldMessengerError(context, "error happened");
          }
          else if (state is AppointmentSuccess){
            Navigator.pop(context);
            Navigator.pop(context);
            scaffoldMessengerError(context, "Appointment Done Successfully",color: Colors.green);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AppointmentCubit>();

          return Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Gap(5.h),
                CustomText(text: doctorName, alignment: AlignmentGeometry.center, fontWeight: FontWeight.bold),
                CustomDivider(),
                CustomText(text: "Select Date", color: Colors.black, fontWeight: FontWeight.bold),
                EasyDateTimeLinePicker.itemBuilder(
                  controller: cubit.controller,
                  focusedDate: cubit.dateTime,
                  // اجعل هذا ديناميكياً بناءً على اختيارك
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030, 3, 18),
                  itemExtent: 60.w,
                  currentDate: DateTime.now(),
                  itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
                    final String dayName = DateFormat("EEE").format(date);

                    // مقارنة التاريخ الحالي بالتاريخ المختار في الـ Cubit
                    // نستخدم isSameDay للتأكد من تجاهل الوقت (الساعات والدقائق)
                    bool isDaySelected =
                        date.year == cubit.dateTime?.year &&
                        date.month == cubit.dateTime?.month &&
                        date.day == cubit.dateTime?.day;

                    return GestureDetector(
                      onTap: () {
                        // 2. Call a method that emits a state
                        cubit.changeDate(date);
                        print(date);
                      },
                      child: SizedBox(
                        height: 40, // تأكد من الارتفاع المناسب
                        child: Container(
                          decoration: BoxDecoration(
                            // التغيير سيحدث الآن لأن BlocBuilder سيعيد بناء الواجهة
                            color: isDaySelected ? AppColors.kPrimary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: dayName,
                                color: isDaySelected ? Colors.white : Colors.black,
                                // تغيير لون النص أيضاً
                                alignment: AlignmentGeometry.center,
                                size: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: date.day.toString(),
                                color: isDaySelected ? Colors.white : Colors.black,
                                alignment: AlignmentGeometry.center,
                                size: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onDateChange: (date) {
                    print("object");
                    // يمكنك استخدام هذا أيضاً بدلاً من onTap في GestureDetector
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
                          CustomText(text: "Select Time", color: Colors.black, fontWeight: FontWeight.bold),
                          Icon(CupertinoIcons.clock),
                        ],
                      ),
                    ),
                    CustomText(text: cubit.timeOfDay!.format(context).toString()),
                  ],
                ),
                CustomDivider(),

                SizedBox(
                  height: 100.h,
                  child: CustomTextFormField(hintText: "Notes", isExpand: true),
                ),
                Gap(10.h),
                state is AppointmentLoading
                    ? Lottie.asset("assets/lottie/Trail_loading.json", height: 50.h)
                    : CustomButton(
                        text: "Appointment",
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
