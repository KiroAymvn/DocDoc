import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/favorites/data/presentation/favorites_cubit.dart';
import 'package:appointment/features/home%20screen/screens/about_doctor_screen.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackGround,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoaded) {
                    if (state.favorites.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildFavoritesList(context, state.favorites);
                  }
                  // Initial state — show empty state
                  return _buildEmptyState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // Header
  // ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'My Favorites ❤️',
            size: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.kDarkText,
          ),
          Gap(4.h),
          CustomText(
            text: 'Doctors you have saved for quick access',
            size: 13,
            color: AppColors.kTextMuted,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // Empty State
  // ──────────────────────────────────────────────────────────────

  Widget _buildEmptyState() {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation for an engaging empty state
          Gap(20.h),
          CustomText(
            text: 'No favorites yet',
            size: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.kDarkText,
            alignment: Alignment.center,
          ),
          Gap(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: CustomText(
              text: 'Tap the ❤️ on any doctor\'s profile to save them here.',
              size: 14,
              color: AppColors.kTextMuted,
              fontWeight: FontWeight.w400,
              alignment: Alignment.center,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // Favorites List
  // ──────────────────────────────────────────────────────────────

  Widget _buildFavoritesList(
    
    BuildContext context,
    List<DoctorModel> favorites,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final doctor = favorites[index];
        return _FavoriteDoctorCard(doctor: doctor);
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Favorite Doctor Card Widget
// ──────────────────────────────────────────────────────────────

class _FavoriteDoctorCard extends StatelessWidget {
  const _FavoriteDoctorCard({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Swipe left to remove from favorites
      key: ValueKey(doctor.doctorId),
      direction: DismissDirection.endToStart,
      background: _buildSwipeBackground(),
      onDismissed: (_) async {
        await context.read<FavoritesCubit>().toggleFavorite(doctor);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.kError,
            content: Text('${doctor.name} removed from favorites'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AboutDoctorScreen(doctor: doctor),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.all(14.sp),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.kCardShadow.withOpacity(0.07),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Doctor Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.asset(
                  'assets/images/man3.png',
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(14.w),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: doctor.name,
                      size: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kDarkText,
                      maxLines: 1,
                    ),
                    Gap(4.h),
                    CustomText(
                      text: doctor.specialization.specialityName,
                      size: 13,
                      color: AppColors.kTextMuted,
                      maxLines: 1,
                    ),
                    Gap(2.h),
                    CustomText(
                      text: doctor.degree,
                      size: 12,
                      color: AppColors.kTextMuted,
                      maxLines: 1,
                    ),
                    Gap(8.h),
                    Row(
                      children: [
                        // Price badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomText(
                            text: '${doctor.appointPrice} LE',
                            color: AppColors.kPrimary,
                            size: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Heart icon (already favorited)
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Red background shown when swiping left on a card
  Widget _buildSwipeBackground() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.kError,
        borderRadius: BorderRadius.circular(18.r),
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_rounded, color: Colors.white, size: 26.sp),
          Gap(4.h),
          Text(
            'Remove',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
