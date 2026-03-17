import 'package:appointment/features/auth/screens/signup_screen.dart';
import 'package:appointment/features/profile%20screen/data/presentation/get%20user%20cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';
import 'package:lottie/lottie.dart';

// Imports of your provided files
import '../../../core/constant/app_colors.dart';
import '../../../core/models/user_model.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_scaffold_messanger.dart';
import '../../../shared/custom_text_form_field.dart';
import '../../auth/widgets/custom_dialog_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;

  const EditProfileScreen({super.key, required this.userModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
   TextEditingController _passwordController=TextEditingController();

  // Form Key for Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _nameController = TextEditingController(text: widget.userModel.name);
    _emailController = TextEditingController(text: widget.userModel.email);
    _phoneController = TextEditingController(text: widget.userModel.phone);
    _genderController = TextEditingController(text: widget.userModel.gender);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  late final String gender=  widget.userModel.gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackGround,
      appBar: AppBar(
        backgroundColor: AppColors.kBackGround,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          text: "Edit Profile",
          size: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kDarkText,
          alignment: Alignment.center,
        ),
      ),
      body: BlocConsumer<GetUserCubit, GetUserState>(
        listener: (context, state) {
          if (state is GetUserSuccess) {
            Navigator.pop(context);
            scaffoldMessengerError(context, "Profile Updated successfully", color: AppColors.kSuccess);
          }

          if (state is GetUserFailed) {
            final error = state.apiError;
            showDialog(
              context: context,
              builder: (context) => CustomDialogWidget(error: error, isSignUp: true),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<GetUserCubit>();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // --- 1. Profile Picture Section ---
                  SizedBox(height: 20.h),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.kPrimary.withOpacity(0.3), width: 3),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/man1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 32.w,
                        width: 32.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 36.h),

                  // --- 2. Form Fields ---

                  // Name
                  _buildLabel("Full Name"),
                  CustomTextFormField(
                    hintText: "Name",
                    controller: _nameController,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 16.h),

                  // Email
                  _buildLabel("Email Address"),
                  CustomTextFormField(
                    hintText: "Email",
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),

                  // Phone
                  _buildLabel("Phone Number"),
                  CustomTextFormField(
                    hintText: "Phone",
                    controller: _phoneController,
                    textInputType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel("Your Password"),
                  CustomTextFormField(
                    hintText: "password",
                    controller: _passwordController,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 16.h),

                  // Gender
                  SizedBox(height: 40.h),

                  // --- 3. Update Button ---
                   SizedBox(
                          width: double.infinity,
                          child: state is GetUserLoading
                              ? Lottie.asset("assets/lottie/Trail_loading.json",height: 50.h)
                              : CustomButton(
                            text: "Update Profile",
                            textSize: 16,
                            onTap: () {
                              cubit.updateUser(
                                password: _passwordController.text,
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                gender: gender,
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper widget for field labels
  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: label,
          size: 13,
          color: AppColors.kTextMuted,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
