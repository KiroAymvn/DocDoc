import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من استيراد هذا لأجل .w و .h
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
    // 1. استخدمنا Dialog بدلاً من AlertDialog لتجنب مشاكل الـ Intrinsic Dimensions
    return Dialog(
      backgroundColor: AppColors.kBackGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      // 2. Padding داخلي للبطاقة
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 3. يجعل الـ Dialog ينكمش على حجم المحتوى
          children: [
            // --- العنوان ---
            CustomText(
              text: "Please Try again",
              alignment: Alignment.center,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: 18,
            ),

            SizedBox(height: 16.h),

            // --- المحتوى ---
            if (isSignUp)
              Column(
                children: [
                  // عرض أخطاء الحقول المحددة
                  if (error.emailError != null)
                    _buildErrorText(error.emailError!),

                  if (error.passwordError != null)
                    _buildErrorText(error.passwordError!),

                  if (error.phoneError != null)
                    _buildErrorText(error.phoneError!),

                  // الرسالة العامة (الحل لمشكلة الـ 422)
                  // إذا كان الـ API يرسل الخطأ داخل "data" ولكن ليس في الحقول المتوقعة،
                  // نعرض الرسالة العامة القادمة من الباك إند
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

            SizedBox(height: 20.h),

            // --- زر الإغلاق ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لتنسيق نص الخطأ
  Widget _buildErrorText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: text,
        size: 14,
        color: Colors.red,
        textAlign: TextAlign.center,
        alignment: Alignment.center,
        maxLines: 3, // مهم جداً لمنع overflow
      ),
    );
  }
}