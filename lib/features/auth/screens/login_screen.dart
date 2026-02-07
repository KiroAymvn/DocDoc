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
import 'package:google_fonts/google_fonts.dart';

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
                  padding: EdgeInsetsGeometry.all(ScreenSize.screenWidth(context) * 0.040),
                  child: ListView(
                    children: [
                      LogoDocdoc(),
                      Gap(25.h),
                      CustomText(text: "Welcome Back", size: 25, fontWeight: FontWeight.bold),
                      CustomText(
                        text:
                            "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                        size: 15,
                        color: AppColors.kGrey,
                        textAlign: TextAlign.left,
                      ),
                      Gap(25.h),
                      CustomTextFormField(hintText: "email", controller: cubit.loginEmailController),
                      Gap(20.h),
                      CustomTextFormField(
                        hintText: "password",
                        controller: cubit.loginPasswordController,
                        isObscureText: true,
                      ),
                      Gap(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRememberForgotWidget(val: _val),
                          CustomText(text: "Forgot Password?", size: 15),
                        ],
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "Create Account",
                              textSize: 15,
                              backGroundColor: Colors.white,
                              borderColor: AppColors.kPrimary,
                              textColor: AppColors.kPrimary,
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              ),
                            ),
                          ),
                          Gap(5.w),
                          Expanded(
                            child: state is AuthLoading
                                ? CupertinoActivityIndicator()
                                : CustomButton(
                                    text: "login",
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
                          Expanded(child: Divider()),
                          CustomText(text: " or sign in with ", size: 12, color: AppColors.kGrey),
                          Expanded(child: Divider()),
                        ],
                      ),
                      Gap(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(signInWith.length, growable: true, (index) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 25.r,
                            child: Center(child: SvgPicture.asset(signInWith[index], height: 35.h)),
                          );
                        }),
                      ),
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
