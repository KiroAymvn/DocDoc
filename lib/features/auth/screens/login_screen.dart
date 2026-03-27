import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/features/auth/data/presenation/auth_cubit.dart';
import 'package:appointment/features/auth/screens/signup_screen.dart';
import 'package:appointment/features/home%20screen/screens/Home_screen.dart';
import 'package:appointment/root.dart';
import 'package:appointment/shared/custom_button.dart';
import 'package:appointment/shared/custom_scaffold_messanger.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:appointment/shared/logo_docdoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/custom_text_form_field.dart';
import '../widgets/custom_dialog_widget.dart';
import '../widgets/custom_remember_forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
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
    final ValueNotifier<bool> _val = ValueNotifier(false);
    List<String> signInWith = [
      "assets/icons/google.svg",
      "assets/icons/facebook.svg",
      "assets/icons/apple.svg",
    ];
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Root()),
          );
        } else if (state is AuthFailed) {
          final error = state.apiError;
          scaffoldMessengerError(context, "Invalid email or password");
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
                            Gap(36.h),
                            CustomText(
                              text: "Welcome Back",
                              size: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.kDarkText,
                            ),
                            Gap(8.h),
                            CustomText(
                              text:
                                  "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                              size: 14,
                              color: AppColors.kTextMuted,
                              textAlign: TextAlign.left,
                            ),
                            Gap(32.h),

                            // ── Form fields with prefix icons ──
                            _buildFieldLabel("Email Address"),
                            Gap(6.h),
                            CustomTextFormField(
                              hintText: "email",
                              controller: cubit.loginEmailController,
                            ),
                            Gap(20.h),
                            _buildFieldLabel("Password"),
                            Gap(6.h),
                            CustomTextFormField(
                              hintText: "password",
                              controller: cubit.loginPasswordController,
                              isObscureText: true,
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
                            Gap(28.h),

                            // ── Action buttons ──
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: "Create Account",
                                    textSize: 14,
                                    backGroundColor: Colors.white,
                                    borderColor: AppColors.kPrimary,
                                    textColor: AppColors.kPrimary,
                                    onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(10.w),
                                Expanded(
                                  child: state is AuthLoading
                                      ? Container(
                                          height: 52.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimary
                                                .withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(
                                              14.r,
                                            ),
                                          ),
                                          child: const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        )
                                      : CustomButton(
                                          text: "Login",
                                          useGradient: true,
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              cubit.login(
                                                email: cubit
                                                    .loginEmailController
                                                    .text,
                                                password: cubit
                                                    .loginPasswordController
                                                    .text,
                                              );
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                            Gap(40.h),

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
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: AppColors.kBorder,
                                    ),
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
                              children: List.generate(
                                signInWith.length,
                                growable: true,
                                (index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        onTap: () {},
                                        child: Container(
                                          width: 62.w,
                                          height: 62.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            border: Border.all(
                                              color: AppColors.kBorder
                                                  .withOpacity(0.6),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.kCardShadow
                                                    .withOpacity(0.08),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              signInWith[index],
                                              height: 26.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
