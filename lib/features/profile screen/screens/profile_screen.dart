import 'dart:math';

import 'package:appointment/core/constant/app_colors.dart';

import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/features/profile%20screen/data/presentation/get%20user%20cubit/get_user_cubit.dart';
import 'package:appointment/features/profile%20screen/data/presentation/logout/logout_cubit.dart';
import 'package:appointment/features/profile%20screen/screens/update_screen.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'logout_dialog.dart';
import '../widgets/custom_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String passObsc(String pass) {
    String obsc = "";
    for (int i = 0; i < pass.length; i++) {
      obsc = "$obsc*";
    }
    return obsc;
  }

  void onPressed() {
    context.read<LogoutCubit>().logout(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    context.read<GetUserCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  state is GetUserSuccess
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfileScreen(userModel: state.userModel)),
                        )
                      : null;
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.kBorder),
                    ),
                    child: SvgPicture.asset("assets/icons/edit-2.svg", height: 20.h),
                  ),
                ),
              );
            },
          ),
        ],
        title: CustomText(
          text: "Personal Information",
          size: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kDarkText,
          alignment: Alignment.center,
        ),
      ),
      body: BlocConsumer<GetUserCubit, GetUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<GetUserCubit>();
          return Skeletonizer(
            enabled: state is GetUserLoading,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gradient header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20.h, bottom: 28.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kPrimary.withOpacity(0.06),
                          AppColors.kBackGround,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Skeleton.ignore(
                          child: SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: ClipRect(
                              child: CachedNetworkImage(
                                width: 100.h,
                                height: 100.h,
                                imageUrl:
                                    "https://th.bing.com/th/id/R.1e421b84ef27a47cbfd13d9537d7d37b?rik=5HacnClWK%2bURSg&pid=ImgRaw&r=0",
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 100.h,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.kLightGrey,
                                      border: Border.all(color: AppColors.kPrimary.withOpacity(0.3), width: 3),
                                      image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                                    ),
                                  );
                                },
                                progressIndicatorBuilder: (context, url, progress) {
                                  return SizedBox(
                                    width: 100.h,
                                    height: 100.h,
                                    child: Center(
                                      child: Lottie.asset("assets/lottie/Trail_loading.json", width: 40.h, height: 40.h),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) => SizedBox(
                                  width: 100.h,
                                  height: 100.h,
                                  child: const Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(12.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: state is GetUserSuccess ? state.userModel.name : "",
                              size: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kDarkText,
                              alignment: Alignment.center,
                            ),
                            Gap(6.w),
                            Icon(Icons.male, color: AppColors.kPrimary, size: 22.sp),
                          ],
                        ),
                        Gap(4.h),
                        CustomText(
                          text: "PATIENT ID : ${state is GetUserSuccess ? state.userModel.id : ""}",
                          size: 13,
                          color: AppColors.kTextMuted,
                          fontWeight: FontWeight.w400,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                  Gap(8.h),
                  CustomUserDataListTile(
                    title: "Email address",
                    subTitle: state is GetUserSuccess ? state.userModel.email : "",
                    icon: CupertinoIcons.mail_solid,
                  ),
                  CustomUserDataListTile(
                    title: "Phone Number",
                    subTitle: state is GetUserSuccess ? state.userModel.phone : "",
                    icon: CupertinoIcons.phone_fill,
                  ),
                  CustomUserDataListTile(
                    title: "Password",
                    subTitle: passObsc("521312"),
                    icon: CupertinoIcons.lock_fill,
                  ),
                  Gap(30.h),
                  BlocConsumer<LogoutCubit, LogoutState>(
                    listener: (context, state) async {
                      if (state is LogoutLoading) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              icon: Lottie.asset("assets/lottie/Trail_loading.json", height: 50.h, width: 50.w),
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: GestureDetector(
                          onTap: () {
                            SignoutDialog(context, state, onPressed).show();
                          },
                          child: Container(
                            width: 250.w,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(color: AppColors.kError, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout_rounded, color: AppColors.kError, size: 20.sp),
                                SizedBox(width: 8.w),
                                CustomText(
                                  text: "Sign out",
                                  color: AppColors.kError,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
