import 'dart:math';

import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/features/profile%20screen/data/presentation/get%20user%20cubit/get_user_cubit.dart';
import 'package:appointment/features/profile%20screen/data/presentation/logout/logout_cubit.dart';
import 'package:appointment/features/profile%20screen/screens/update_screen.dart';
import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  padding: EdgeInsets.only(right: ScreenSize.screenWidth(context) * 0.05),
                  child: SvgPicture.asset("assets/icons/edit-2.svg"),
                ),
              );
            },
          ),
        ],
        backgroundColor: AppColors.kBackGround,
        centerTitle: true,
        title: CustomText(
          text: "Personal information",
          alignment: AlignmentGeometry.centerLeft,
          textAlign: TextAlign.center,
          color: Colors.black,
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
                  Gap(20.h),
                  // Lottie.asset("assets/lottie/Trail_loading.json"),
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
                                color: AppColors.kGrey.withOpacity(0.25),
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
                  Gap(10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: state is GetUserSuccess ? state.userModel.name : "",
                        alignment: AlignmentGeometry.center,
                        size: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Gap(5.w),
                      Icon(Icons.male, color: AppColors.kPrimary),
                    ],
                  ),
                  Gap(5.h),
                  CustomText(
                    text: "PATIENT ID : ${state is GetUserSuccess ? state.userModel.id : ""}",
                    alignment: AlignmentGeometry.center,
                    size: 15,
                    color: AppColors.kGrey,
                    fontWeight: FontWeight.normal,
                  ),
                  Gap(20.h),
                  CustomUserDataListTile(
                    title: "Email address",
                    subTitle: state is GetUserSuccess ? state.userModel.email : "",
                    icon: CupertinoIcons.mail_solid,
                  ),
                  CustomUserDataListTile(
                    title: "phone Number",
                    subTitle: state is GetUserSuccess ? state.userModel.phone : "",
                    icon: CupertinoIcons.phone_fill,
                  ),
                  CustomUserDataListTile(
                    title: "Password",
                    subTitle: passObsc("521312"),
                    icon: CupertinoIcons.phone_fill,
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
                      return CustomButton(
                        text: "Sign out",
                        onTap: () {
                          SignoutDialog(context, state, onPressed).show();
                        },
                        backGroundColor: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
