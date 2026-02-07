import 'package:appointment/features/search%20doctor/data/presentaion/search_doctor_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constant/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.color = Colors.white,
    super.key,
    required this.hintText,
    this.textColor = AppColors.kPrimary,
    this.controller,
    this.readOnly = false,
    this.textInputType = TextInputType.name,
    this.isObscureText = false,
    this.isExpand = false,
    this.isSearch = false,
  });

  final bool readOnly;
  final TextInputType textInputType;
  final Color? color;
  final Color? textColor;
  final String hintText;
  TextEditingController? controller = TextEditingController();
  final bool isObscureText;
  final bool isExpand;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _val = ValueNotifier<bool>(true);

    return ValueListenableBuilder(
      valueListenable: _val,

      builder: (context, value, child) {
        return TextFormField(
          onChanged: (search) {
            isSearch ? context.read<SearchDoctorCubit>().searchDoctor(doctorName: search) : null;
          },
          textAlignVertical: TextAlignVertical.top,
          maxLines: isExpand ? null : 1,
          expands: isExpand,
          textAlign: TextAlign.left,
          obscureText: isObscureText ? _val.value : false,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "enter your $hintText";
            } else if (hintText.toLowerCase() == "email") {
              if (!value.endsWith("@gmail.com")) {
                return "email must contain @gmail.com";
              }
            } else if (hintText == "password") {
              if (value.length < 6) {
                return "$hintText must be more than 6 character ";
              }
            } else if (hintText.toLowerCase() == "confirm password") {
              if (value.length < 6) {
                return "$hintText must be more than 6 character ";
              }
            } else {
              return null;
            }
            return null;
          },
          keyboardType: textInputType,
          decoration: InputDecoration(
            contentPadding: EdgeInsetsGeometry.symmetric(vertical: 15.h, horizontal: 10.h),
            filled: true,
            fillColor: color,
            hintText: hintText,
            hintStyle: GoogleFonts.inter(color: AppColors.kGrey, fontSize: 15.sp),
            suffixIcon: isObscureText
                ? GestureDetector(
                    onTap: () {
                      _val.value = !_val.value;
                      print(_val.value);
                    },
                    child: _val.value ? Icon(CupertinoIcons.eye) : Icon(CupertinoIcons.eye_slash),
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          cursorColor: AppColors.kPrimary,
          style: GoogleFonts.inter(color: textColor),
        );
      },
    );
  }
}
