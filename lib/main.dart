import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';
import 'package:appointment/features/auth/data/presenation/auth_cubit.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:appointment/features/auth/screens/signup_screen.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/all_doctors_cubit.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/home_cubit.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/speciality_cubit.dart';
import 'package:appointment/features/profile%20screen/data/presentation/logout/logout_cubit.dart';
import 'package:appointment/features/profile%20screen/screens/profile_screen.dart';
import 'package:appointment/features/search%20doctor/data/presentaion/search_doctor_cubit.dart';
import 'package:appointment/root.dart';
import 'package:appointment/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/appointment/data/presentation/appointment_cubit.dart';
import 'features/profile screen/data/presentation/get user cubit/get_user_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AllDoctorsCubit>(
        create: (context) => AllDoctorsCubit(),
        lazy: true,
      ),
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        lazy: true,
      ),
      BlocProvider<SpecialityCubit>(
        create: (context) => SpecialityCubit(),
        lazy: true,
      ),
      BlocProvider<SearchDoctorCubit>(
        create: (context) => SearchDoctorCubit(),
        lazy: true,
      ),
      BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(),
        lazy: true,
      ),
      BlocProvider<LogoutCubit>(
        create: (context) => LogoutCubit(),
        lazy: true,
      ),
      BlocProvider<GetUserCubit>(
        create: (context) => GetUserCubit(),
        lazy: true,
      ),

      BlocProvider<AppointmentCubit>(
        create: (context) => AppointmentCubit(),
        lazy: true,
      ),
    ], child: DevicePreview(

      //enabled: !kReleaseMode,
       enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),)
    ,);
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
return ScreenUtilInit(
  designSize: const Size(360, 690),
  minTextAdapt: true,
  splitScreenMode: true,
  // Use builder only if you need to use library outside ScreenUtilInit context
  builder: (_ , child) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kBackGround,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.kBackGround,
          surfaceTintColor : AppColors.kBackGround,
          
        ),
      ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  },
);
  }}

