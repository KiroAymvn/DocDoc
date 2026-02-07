import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constant/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text,
    this.textColor=Colors.white,
    this.textSize = 20, this.onTap, this.backGroundColor = AppColors.kPrimary,this.borderColor});

  final String text;
 final Color? backGroundColor;
 final Color? textColor;
  Color? borderColor;
  double? textSize;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250.w,
        height: 50.h,
        decoration: BoxDecoration(color: backGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),border: borderColor!=null ?Border.all(color: borderColor!,width: 2.w):Border.all(color: Colors.transparent)),
        child: Center(
          child: CustomText(
            text: text,
            color: textColor,
            size: textSize,
            alignment: AlignmentGeometry.center,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
