import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../data/presentation/logout/logout_cubit.dart';

AwesomeDialog SignoutDialog(BuildContext context, LogoutState state,void Function() onPressed) {
  return AwesomeDialog(
    context: context,
    dismissOnTouchOutside: false,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    // مهم عشان نعمل UI مخصص
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ICON
          Container(
            padding: EdgeInsets.all(14.h),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBackGround),
            child: Icon(Icons.logout_rounded, color: Colors.red, size: 32.sp),
          ),

          SizedBox(height: 16.h),

          // TITLE
          CustomText(
            text: "We hope you are ok now",
            size: 16,
            fontWeight: FontWeight.w600,
            alignment: Alignment.center,
          ),

          SizedBox(height: 10.h),

          // DESCRIPTION
          CustomText(
            text:
            "In case you signed out, the next time you open the app you will need to enter your email and password again.",
            size: 12,
            color: AppColors.kGrey,
            maxLines: 4,
            alignment: Alignment.center,
          ),

          SizedBox(height: 22.h),

          // BUTTONS
          Row(
            children: [
              // CANCEL
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: BorderSide(color: AppColors.kPrimary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(text: "Cancel", size: 13, color: AppColors.kPrimary, alignment: Alignment.center),
                ),
              ),

              SizedBox(width: 12.w),

              // SIGN OUT
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    onPressed();
                  },
                  child: CustomText(text: "Sign out", size: 13, color: Colors.white, alignment: Alignment.center),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
