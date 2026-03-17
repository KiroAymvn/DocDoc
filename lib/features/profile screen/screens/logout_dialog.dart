import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';

import '../../../core/constant/app_colors.dart';
import '../data/presentation/logout/logout_cubit.dart';

AwesomeDialog SignoutDialog(BuildContext context, LogoutState state,void Function() onPressed) {
  return AwesomeDialog(
    context: context,
    dismissOnTouchOutside: false,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ICON
          Container(
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kError.withOpacity(0.1),
            ),
            child: Icon(Icons.logout_rounded, color: AppColors.kError, size: 32.sp),
          ),

          SizedBox(height: 20.h),

          // TITLE
          CustomText(
            text: "We hope you are ok now",
            size: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.kDarkText,
            textAlign: TextAlign.center,
            alignment: Alignment.center,
          ),

          SizedBox(height: 10.h),

          // DESCRIPTION
          CustomText(
            text: "In case you signed out, the next time you open the app you will need to enter your email and password again.",
            size: 13,
            color: AppColors.kTextMuted,
            textAlign: TextAlign.center,
            alignment: Alignment.center,
            maxLines: 4,
          ),

          SizedBox(height: 24.h),

          // BUTTONS
          Row(
            children: [
              // CANCEL
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: BorderSide(color: AppColors.kBorder),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(
                    text: "Cancel",
                    size: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kDarkText,
                    alignment: Alignment.center,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // SIGN OUT
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: AppColors.kError,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  onPressed: () {
                    onPressed();
                  },
                  child: CustomText(
                    text: "Sign out",
                    size: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
