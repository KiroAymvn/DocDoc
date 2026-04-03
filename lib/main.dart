import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/storage/hive_service.dart';
import 'package:appointment/features/auth/data/presenation/auth_cubit.dart';
import 'package:appointment/features/favorites/data/presentation/favorites_cubit.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/all_doctors_cubit.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/home_cubit.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/speciality_cubit.dart';
import 'package:appointment/features/profile%20screen/data/presentation/logout/logout_cubit.dart';
import 'package:appointment/features/search%20doctor/data/presentaion/search_doctor_cubit.dart';
import 'package:appointment/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/appointment/data/presentation/appointment_cubit.dart';
import 'features/profile screen/data/presentation/get user cubit/get_user_cubit.dart';

void main() async {
  // Must be called before any async work before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open all boxes (favorites, home data, all doctors)
  await HiveService.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AllDoctorsCubit>(
          create: (_) => AllDoctorsCubit(),
          lazy: true,
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
          lazy: true,
        ),
        BlocProvider<SpecialityCubit>(
          create: (_) => SpecialityCubit(),
          lazy: true,
        ),
        BlocProvider<SearchDoctorCubit>(
          create: (_) => SearchDoctorCubit(),
          lazy: true,
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
          lazy: true,
        ),
        BlocProvider<LogoutCubit>(
          create: (_) => LogoutCubit(),
          lazy: true,
        ),
        BlocProvider<GetUserCubit>(
          create: (_) => GetUserCubit(),
          lazy: true,
        ),
        BlocProvider<AppointmentCubit>(
          create: (_) => AppointmentCubit(),
          lazy: true,
        ),
        // FavoritesCubit is NOT lazy — it loads favorites from Hive immediately
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(),
          lazy: false,
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kBackGround,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.kBackGround,
              surfaceTintColor: AppColors.kBackGround,
            ),
          ),
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
