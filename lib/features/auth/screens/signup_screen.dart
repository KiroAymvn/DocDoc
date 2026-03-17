import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/auth/data/presenation/auth_cubit.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:appointment/shared/logo_docdoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _val = ValueNotifier(false);
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

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
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      AppColors.kBackGround,
                      AppColors.kPrimary.withOpacity(0.03),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.screenWidth(context) * 0.050,
                      vertical: ScreenSize.screenWidth(context) * 0.020,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: ListView(
                          children: [
                            Gap(10.h),
                            LogoDocdoc(),
                            Gap(30.h),
                            CustomText(
                              text: "Create your account",
                              size: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.kDarkText,
                            ),
                            Gap(8.h),
                            CustomText(
                              text: "Please take a few minutes to fill out your profile with as much detail as possible.",
                              size: 14,
                              color: AppColors.kTextMuted,
                              textAlign: TextAlign.left,
                            ),
                            Gap(28.h),

                            // ── Full Name ──
                            _buildFieldLabel("Full Name"),
                            Gap(6.h),
                            CustomTextFormField(hintText: "Full Name", controller: cubit.fullNameController),
                            Gap(18.h),

                            // ── Email ──
                            _buildFieldLabel("Email Address"),
                            Gap(6.h),
                            CustomTextFormField(hintText: "Email", controller: cubit.emailController),
                            Gap(18.h),

                            // ── Phone & Gender ──
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFieldLabel("Phone"),
                                      Gap(6.h),
                                      CustomTextFormField(
                                        hintText: "Phone",
                                        controller: cubit.phoneController,
                                        textInputType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(10.w),
                                MaleFemaleWidget(cubit: cubit),
                              ],
                            ),
                            Gap(18.h),

                            // ── Password ──
                            _buildFieldLabel("Password"),
                            Gap(6.h),
                            CustomTextFormField(
                              hintText: "Password",
                              isObscureText: true,
                              controller: cubit.passwordController,
                            ),
                            Gap(18.h),

                            // ── Confirm Password ──
                            _buildFieldLabel("Confirm Password"),
                            Gap(6.h),
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
                                GestureDetector(
                                  onTap: () {},
                                  child: CustomText(
                                    text: "Forgot Password?",
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Gap(24.h),

                            // ── Action buttons ──
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
                                      ? Container(
                                          height: 52.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimary.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(14.r),
                                          ),
                                          child: const Center(child: CupertinoActivityIndicator()),
                                        )
                                      : CustomButton(
                                          text: "Sign up",
                                          useGradient: true,
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
                            Gap(36.h),

                            // ── Social sign-in divider ──
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          AppColors.kBorder,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: AppColors.kBorder),
                                  ),
                                  child: CustomText(
                                    text: "OR",
                                    color: AppColors.kTextMuted,
                                    size: 12,
                                    fontWeight: FontWeight.w600,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.kBorder,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(24.h),

                            // ── Social sign-in buttons ──
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(signInWith.length, growable: true, (index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16.r),
                                      onTap: () {},
                                      child: Container(
                                        width: 62.w,
                                        height: 62.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16.r),
                                          border: Border.all(color: AppColors.kBorder.withOpacity(0.6)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.kCardShadow.withOpacity(0.08),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: Center(child: SvgPicture.asset(signInWith[index], height: 26.h)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Gap(24.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: CustomText(
        text: label,
        size: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.kDarkText.withOpacity(0.7),
      ),
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
