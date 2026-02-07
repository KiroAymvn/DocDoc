import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/features/appointment/screen/my_appointment_screen.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:appointment/features/auth/screens/signup_screen.dart';
import 'package:appointment/features/home%20screen/screens/Home_screen.dart';
import 'package:appointment/features/profile%20screen/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

import 'core/utils/pref_helper.dart';
import 'features/appointment/data/model/appointment_model.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int? activeIndex = 0;
  List<Widget> screens = [HomeScreen(), MyAppointmentScreen(), ProfileScreen()];

  void _onTabTapped(int index) {
    setState(() => activeIndex = index);
  }
  void getAppointmentCount ()async{
    final List<AppointmentModel>? l= await context.read<AppointmentCubit>().getAppointment();
    context.read<AppointmentCubit>().appointmentCount=l!.length;
    final count=context.read<AppointmentCubit>().appointmentCount;
    await PrefHelper.saveAppointmentCount(count: count);
    context.read<AppointmentCubit>().appointmentCount=await PrefHelper.getAppointmentCount()??0;

  }
  @override
  void initState() {
    getAppointmentCount();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex as int],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GlazeNavBar(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.kPrimary, AppColors.kBackGround, AppColors.kPrimary],
        ),
        buttonGradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.kPrimary, AppColors.kPrimary],
        ),
        animationDuration: Duration(milliseconds: 500),

        onTap: _onTabTapped,
        buttonBorderColor: Colors.transparent,
        buttonBackgroundColor: Colors.red,
        height: 50.h,
        animationCurve: FlippedCurve(Easing.legacy),
        items: [
          GlazeNavBarItem(
            child: SvgPicture.asset("assets/icons/home-2.svg", color: activeIndex == 0 ? Colors.white : Colors.black),
            label: "Home",
            activeBadgeColor: Colors.white,
            activeBadgeTextColor: Colors.red,
          ),
          GlazeNavBarItem(
            badgeCount: context.read<AppointmentCubit>().appointmentCount != 0
                ? context.read<AppointmentCubit>().appointmentCount
                : null,
            child: SvgPicture.asset(
              "assets/icons/calendar-2.svg",
              color: activeIndex == 1 ? Colors.white : Colors.black,
            ),
            label: "Appointments",
          ),
          GlazeNavBarItem(
            child: SvgPicture.asset(
              "assets/icons/setting-4.svg",
              color: activeIndex == 2 ? Colors.white : Colors.black,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
