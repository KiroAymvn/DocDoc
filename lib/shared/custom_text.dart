import 'package:appointment/core/constant/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    this.color = AppColors.kPrimary,
    this.size= 20,
    this.fontWeight = FontWeight.normal,
    this.alignment = Alignment.centerLeft,
    this.maxLines = 5,
    this.textAlign=TextAlign.center
  });
final TextAlign textAlign;
  final String text;
  final Color? color;
   double ?size ;
  final FontWeight? fontWeight;
  AlignmentGeometry alignment ;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Align(

      alignment: alignment,
      child: AutoSizeText(
        text,
        minFontSize: 10,
        maxFontSize: size!,
        textAlign: textAlign,
        style: GoogleFonts.inter(color: color, fontSize: size?.sp, fontWeight: fontWeight),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
