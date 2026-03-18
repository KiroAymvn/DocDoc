import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_text.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({
    super.key,
    required this.error,
    this.isSignUp = true,
  });

  final ApiError error;
  final bool isSignUp;

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _pulseController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance animation: scale + fade + slide
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );

    // Subtle pulse on the error icon
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _pulseController]),
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.kError.withOpacity(0.08),
                blurRadius: 40,
                spreadRadius: 0,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top accent bar
            

              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated error icon with glow
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 72.r,
                        height: 72.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.kError.withOpacity(0.15),
                              AppColors.kError.withOpacity(0.05),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 56.r,
                            height: 56.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kError.withOpacity(0.1),
                              border: Border.all(
                                color: AppColors.kError.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: AppColors.kError,
                              size: 30.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Title
                    CustomText(
                      text: "Oops! Something went wrong",
                      alignment: Alignment.center,
                      color: AppColors.kDarkText,
                      fontWeight: FontWeight.w700,
                      size: 17,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 6.h),

                    // Subtitle
                    CustomText(
                      text: "Please review the details below",
                      alignment: Alignment.center,
                      color: AppColors.kTextMuted,
                      fontWeight: FontWeight.w400,
                      size: 13,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 20.h),

                    // Divider
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.kBorder,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Error content card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kError.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColors.kError.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: widget.isSignUp
                          ? Column(
                              children: [
                                if (widget.error.emailError != null)
                                  _buildErrorRow(
                                    Icons.email_outlined,
                                    widget.error.emailError!,
                                  ),
                                if (widget.error.passwordError != null)
                                  _buildErrorRow(
                                    Icons.lock_outline_rounded,
                                    widget.error.passwordError!,
                                  ),
                                if (widget.error.phoneError != null)
                                  _buildErrorRow(
                                    Icons.phone_outlined,
                                    widget.error.phoneError!,
                                  ),
                                if (widget.error.emailError == null &&
                                    widget.error.passwordError == null &&
                                    widget.error.phoneError == null)
                                  _buildErrorRow(
                                    Icons.info_outline_rounded,
                                    widget.error.message ??
                                        "Invalid data provided",
                                  ),
                              ],
                            )
                          : _buildErrorRow(
                              Icons.info_outline_rounded,
                              widget.error.message ??
                                  "Error Code: ${widget.error.statusCode}",
                            ),
                    ),

                    SizedBox(height: 24.h),

                    // Gradient close button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.kPrimary,
                              AppColors.kSecondary,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kPrimary.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: CustomText(text: "Got It",color: AppColors.kBackGround,textAlign: TextAlign.center,alignment: AlignmentGeometry.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.kError.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              icon,
              color: AppColors.kError,
              size: 14.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              text: text,
              size: 13,
              color: AppColors.kError.withOpacity(0.85),
              textAlign: TextAlign.left,
              alignment: Alignment.centerLeft,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}