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

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<bool> _val = ValueNotifier(false);
    List<String> signInWith = ["assets/icons/google.svg", "assets/icons/facebook.svg", "assets/icons/apple.svg"];
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Root()));
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
            onTap: ()=> FocusScope.of(context).unfocus(),
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
                      CustomText(text: "Welcome Back", size: 26, fontWeight: FontWeight.bold, color: AppColors.kDarkText),
                      Gap(8.h),
                      CustomText(
                        text:
                            "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                        size: 14,
                        color: AppColors.kTextMuted,
                        textAlign: TextAlign.left,
                      ),
                      Gap(30.h),
                      CustomTextFormField(hintText: "email", controller: cubit.loginEmailController),
                      Gap(16.h),
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
                          CustomText(text: "Forgot Password?", size: 14, fontWeight: FontWeight.w500),
                        ],
                      ),
                      Gap(24.h),
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
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Expanded(
                            child: state is AuthLoading
                                ? Center(child: CupertinoActivityIndicator())
                                : CustomButton(
                                    text: "Login",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.login(
                                          email: cubit.loginEmailController.text,
                                          password: cubit.loginPasswordController.text,
                                        );
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
