import 'dart:async';

import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/network/connectivity_service.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/features/Onboarding/screens/onBoarding_screen.dart';
import 'package:appointment/root.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _logoOffset;
  late final Animation<Offset> _textOffset;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _controller.forward();
    // Wait for the animation to play, then decide where to navigate
    Future.delayed(const Duration(seconds: 3), _navigate);
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoOffset = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textOffset = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  /// Decides where to navigate after the splash delay.
  ///
  /// Logic:
  /// - Logged in  → go to Root (offline fallback is handled per-repo)
  /// - Not logged in + internet → go to Onboarding
  /// - Not logged in + NO internet → show error (stay on splash or show dialog)
  Future<void> _navigate() async {
    if (!mounted) return;

    final bool isLoggedIn = await PrefHelper.isLogged() ?? false;
    final bool hasInternet = await ConnectivityService.hasInternet();

    if (isLoggedIn) {
      // Always let logged-in users in — repos handle offline fallback
      _goToRoot();
    } else if (hasInternet) {
      // New / logged-out user with internet — show onboarding/login
      _goToOnboarding();
    } else {
      // Not logged in + no internet — show a clear error message
      _showNoInternetError();
    }
  }

  void _goToRoot() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => const Root(),
      ),
    );
  }

  void _goToOnboarding() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => const OnboardingScreen(),
      ),
    );
  }

  /// Shows a full-screen error overlay on top of the splash.
  void _showNoInternetError() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _NoInternetDialog(onRetry: () {
        Navigator.of(context).pop(); // close dialog
        _navigate(); // retry the navigation logic
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.kWhite,
              AppColors.kBackGround,
              AppColors.kPrimary.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: Hero(
            tag: 'docdoc-logo',
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _logoOffset,
                      child: SvgPicture.asset('assets/icons/splash_logo.svg'),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _textOffset,
                      child: CustomText(
                        text: 'DOCDOC',
                        color: AppColors.kDarkText,
                        size: 50,
                        fontWeight: FontWeight.w800,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// No Internet Dialog
// ──────────────────────────────────────────────────────────────

class _NoInternetDialog extends StatelessWidget {
  const _NoInternetDialog({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(28.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.kError.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 48.sp,
                color: AppColors.kError,
              ),
            ),
            Gap(20.h),

            // Title
            CustomText(
              text: 'No Internet Connection',
              size: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.kDarkText,
              alignment: Alignment.center,
            ),
            Gap(10.h),

            // Message
            CustomText(
              text:
                  'You need an internet connection to sign in or create an account. Please check your Wi-Fi or mobile data and try again.',
              size: 14,
              color: AppColors.kTextMuted,
              fontWeight: FontWeight.w400,
              alignment: Alignment.center,
              maxLines: 5,
            ),
            Gap(28.h),

            // Retry Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
