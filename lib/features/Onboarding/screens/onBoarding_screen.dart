import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/custom_text.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/logo_docdoc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(12.h),
            LogoDocdoc(),

            Gap(20.h),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(width: double.infinity, height: 60),
                  SizedBox(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.transparent, Colors.white],
                          stops: [0.0, 0.8.sp],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstATop,
                      child: Image.asset('assets/images/splash_doctor.png', fit: BoxFit.contain, width: double.infinity),
                    ),
                  ),
                  Positioned(
                    bottom: 180.h,
                    left: 0,
                    right: 0,
                    child: CustomText(
                      text: "Best Doctor",
                      textAlign: TextAlign.center,
                      size: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.kDarkText,
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                    bottom: 150.h,
                    left: 0,
                    right: 0,
                    child: CustomText(
                      text: "Appointment App",
                      textAlign: TextAlign.center,
                      size: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kPrimary,
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                    bottom: 110.h,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: "Manage and schedule all of your medical appointments \n easily with Docdoc to get a new experience",
                          textAlign: TextAlign.center,
                          size: 13,
                          color: AppColors.kTextMuted,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 35.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomButton(
                        text: "Get Started",
                        useGradient: true,
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
