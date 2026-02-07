import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
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
                          stops: [0.0, 0.8.sp], // Adjust these values to control fade intensity
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstATop, // This makes the gradient mask the image
                      child: Image.asset('assets/images/splash_doctor.png', fit: BoxFit.contain, width: double.infinity),
                    ),
                  ),
                  Positioned(
                    bottom: 190.h,
                    left: screenWidth/4,
                    child: CustomText(
                      text: "Best Doctor",
                      alignment: AlignmentGeometry.center,
                      fontWeight: FontWeight.bold,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: 150.h,
                    left: screenWidth/8,
                    child: CustomText(
                      text: "Appointment App",
                      alignment: AlignmentGeometry.center,
                      fontWeight: FontWeight.bold,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: 120.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: CustomText(
                        text:
                        "Manage and schedule all of your medical appointments easily ",
                        size: 10,
                        color: AppColors.kGrey,
                        alignment: AlignmentGeometry.center,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100.h,
                    left: 70.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: CustomText(
                        text:
                        "with Docdoc to get a new experience",
                        size: 10,
                        color: AppColors.kGrey,
                        alignment: AlignmentGeometry.center,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth/6,
                    bottom: 30.h,
                      child: CustomButton(text: "Get started",onTap:()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),))

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


