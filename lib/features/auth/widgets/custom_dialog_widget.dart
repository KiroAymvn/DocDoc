import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_text.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    super.key,
    required this.error,
    this.isSignUp = true,
  });

  final ApiError error;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.kError.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.kError,
                size: 36.sp,
              ),
            ),

            SizedBox(height: 20.h),

            // Title
            CustomText(
              text: "Please Try again",
              alignment: Alignment.center,
              color: AppColors.kDarkText,
              fontWeight: FontWeight.bold,
              size: 18,
            ),

            SizedBox(height: 16.h),

            // Content
            if (isSignUp)
              Column(
                children: [
                  if (error.emailError != null)
                    _buildErrorText(error.emailError!),

                  if (error.passwordError != null)
                    _buildErrorText(error.passwordError!),

                  if (error.phoneError != null)
                    _buildErrorText(error.phoneError!),

                  if (error.emailError == null &&
                      error.passwordError == null &&
                      error.phoneError == null)
                    _buildErrorText(error.message ?? "Invalid data provided"),
                ],
              )
            else
              Center(
                child: _buildErrorText(error.message ?? "Error Code: ${error.statusCode}"),
              ),

            SizedBox(height: 24.h),

            // Close button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: text,
        size: 14,
        color: AppColors.kError,
        textAlign: TextAlign.center,
        alignment: Alignment.center,
        maxLines: 3,
      ),
    );
  }
}