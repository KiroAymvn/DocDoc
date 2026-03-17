import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/auth/data/presenation/auth_cubit.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:appointment/features/auth/screens/signup_screen.dart';
import 'package:appointment/features/home%20screen/screens/Home_screen.dart';
import 'package:appointment/root.dart';
import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:appointment/shared/logo_docdoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import '../../../shared/custom_scaffold_messanger.dart';
import '../../../shared/custom_text_form_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../widgets/custom_dialog_widget.dart';
import '../widgets/custom_remember_forgot_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _val = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    List<String> signInWith = ["assets/icons/google.svg", "assets/icons/facebook.svg", "assets/icons/apple.svg"];
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else if (state is AuthFailed) {
          final error = state.apiError;
          showDialog(
            context: context,
            builder: (context) => CustomDialogWidget(error: error, isSignUp: true),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth(context) * 0.050,
                    vertical: ScreenSize.screenWidth(context) * 0.020,
                  ),
                  child: ListView(
                    children: [
                      Gap(10.h),
                      LogoDocdoc(),
                      Gap(30.h),
                      CustomText(text: "Create your account", size: 26, fontWeight: FontWeight.bold, color: AppColors.kDarkText),
                      Gap(8.h),
                      CustomText(
                        text: "Please take a few minutes to fill out your profile with as much detail as possible.",
                        size: 14,
                        color: AppColors.kTextMuted,
                        textAlign: TextAlign.left,
                      ),
                      Gap(30.h),
                      CustomTextFormField(hintText: "Full Name", controller: cubit.fullNameController),
                      Gap(16.h),
                      CustomTextFormField(hintText: "Email", controller: cubit.emailController),
                      Gap(16.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hintText: "Phone",
                              controller: cubit.phoneController,
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Gap(10.w),
                          MaleFemaleWidget(cubit: cubit),
                        ],
                      ),
                      Gap(16.h),
                      CustomTextFormField(
                        hintText: "Password",
                        isObscureText: true,
                        controller: cubit.passwordController,
                      ),
                      Gap(16.h),
                      CustomTextFormField(
                        hintText: "Confirm Password",
                        isObscureText: true,
                        controller: cubit.conformPasswordController,
                      ),
                      Gap(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRememberForgotWidget(val: _val),
                          CustomText(text: "Forgot Password?", size: 14, fontWeight: FontWeight.w500),
                        ],
                      ),
                      Gap(24.h),
                      Row(
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              absorbing: state is AuthLoading,
                              child: CustomButton(
                                text: "Have an account?",
                                textSize: 14,
                                backGroundColor: Colors.white,
                                borderColor: AppColors.kPrimary,
                                textColor: AppColors.kPrimary,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                  );
                                  cubit.fullNameController.clear();
                                  cubit.emailController.clear();
                                  cubit.phoneController.clear();
                                  cubit.passwordController.clear();
                                  cubit.conformPasswordController.clear();
                                },
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Expanded(
                            child: state is AuthLoading
                                ? Center(child: CupertinoActivityIndicator())
                                : CustomButton(
                                    text: "Sign up",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (cubit.passwordController.text != cubit.conformPasswordController.text) {
                                          scaffoldMessengerError(context, "password doesn't match");
                                        } else {
                                          cubit.signUp(
                                            name: cubit.fullNameController.text,
                                            email: cubit.emailController.text,
                                            phone: cubit.phoneController.text,
                                            password: cubit.passwordController.text,
                                            confirmPassword: cubit.conformPasswordController.text,
                                            gender: cubit.gender.toString(),
                                          );
                                        }
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                      Gap(40.h),
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.kBorder)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: CustomText(
                              text: "or sign in with",
                              color: AppColors.kTextMuted,
                              size: 13,
                              alignment: Alignment.center,
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.kBorder)),
                        ],
                      ),
                      Gap(24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(signInWith.length, growable: true, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              width: 56.w,
                              height: 56.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(color: AppColors.kBorder),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(child: SvgPicture.asset(signInWith[index], height: 24.h)),
                            ),
                          );
                        }),
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MaleFemaleWidget extends StatelessWidget {
  const MaleFemaleWidget({
    super.key,
    required this.cubit,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ToggleSwitch(
        centerText: true,
        radiusStyle: true,
        minHeight: 52.h,
        minWidth: 100.w,
        initialLabelIndex: 0,
        curve: Curves.fastEaseInToSlowEaseOut,
        cornerRadius: 14.r,
        activeFgColor: Colors.white,
        inactiveBgColor: AppColors.kLightGrey,
        inactiveFgColor: AppColors.kGrey,
        totalSwitches: 2,
        labels: ['Male', 'Female'],
        icons: [Icons.male, Icons.female],
        animate: true,
        activeBgColors: [
          [AppColors.kPrimary],
          [const Color(0xffec4899)],
        ],
        onToggle: (index) {
          cubit.gender = index!;
        },
      ),
    );
  }
}
