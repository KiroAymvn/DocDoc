import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/features/appointment/screen/my_appointment_screen.dart';
import 'package:appointment/features/home%20screen/screens/Home_screen.dart';
import 'package:appointment/features/profile%20screen/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/utils/pref_helper.dart';
import 'features/appointment/data/model/appointment_model.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int activeIndex = 0;
  List<Widget> screens = [HomeScreen(), MyAppointmentScreen(), ProfileScreen()];

  void _onTabTapped(int index) {
    setState(() => activeIndex = index);
  }

  void getAppointmentCount() async {
    final List<AppointmentModel>? l = await context.read<AppointmentCubit>().getAppointment();
    context.read<AppointmentCubit>().appointmentCount = l!.length;
    final count = context.read<AppointmentCubit>().appointmentCount;
    await PrefHelper.saveAppointmentCount(count: count);
    context.read<AppointmentCubit>().appointmentCount = await PrefHelper.getAppointmentCount() ?? 0;
  }

  @override
  void initState() {
    getAppointmentCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.kBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: "assets/icons/home-2.svg",
                  label: "Home",
                ),
                _buildNavItem(
                  index: 1,
                  icon: "assets/icons/calendar-2.svg",
                  label: "Appointments",
                  badgeCount: context.read<AppointmentCubit>().appointmentCount != 0
                      ? context.read<AppointmentCubit>().appointmentCount
                      : null,
                ),
                _buildNavItem(
                  index: 2,
                  icon: "assets/icons/setting-4.svg",
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
    int? badgeCount,
  }) {
    final bool isSelected = activeIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20.w : 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kPrimary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 22.h,
                  width: 22.w,
                  color: isSelected ? AppColors.kPrimary : AppColors.kTextMuted,
                ),
                if (badgeCount != null)
                  Positioned(
                    top: -6,
                    right: -8,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.kError,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                      child: Center(
                        child: Text(
                          badgeCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.kPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
