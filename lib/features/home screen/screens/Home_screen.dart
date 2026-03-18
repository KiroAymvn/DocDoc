import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/home_cubit.dart';
import 'package:appointment/features/home%20screen/screens/all_doctor_speciality_screen.dart';
import 'package:appointment/features/home%20screen/screens/all_doctors_screen.dart';
import 'package:appointment/features/home%20screen/screens/all_doctors_speciality_list.dart';
import 'package:appointment/features/search%20doctor/screen/search_screen.dart'
    hide CustomDoctorCardWidget;
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/models/speciality_model.dart';
import '../../profile screen/data/presentation/get user cubit/get_user_cubit.dart';
import '../widgets/custom_doctor_card_widget.dart';
import '../widgets/custom_speciality.dart';
import '../widgets/speciality_header_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DoctorModel> getAllDoctorsList(List<HomePageModel> responseList) {
    List<DoctorModel> doctorsList = [];
    for (int i = 0; i < responseList.length; i++) {
      for (int j = 0; j < responseList[i].doctorModelList!.length; j++) {
        doctorsList.add(responseList[i].doctorModelList![j]);
      }
    }
    return doctorsList;
  }

  @override
  void initState() {
    context.read<GetUserCubit>().getUser();
    context.read<HomeCubit>().getHomePageData();
    super.initState();
  }

  List<DoctorModel> doctorList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeSuccess) {
              doctorList = getAllDoctorsList(state.homeDataList);
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is HomeLoading,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.kBackGround,
                      surfaceTintColor: Colors.transparent,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<GetUserCubit, GetUserState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              final cubit = context.read<GetUserCubit>();
                              return state is GetUserLoading
                                  ? CupertinoActivityIndicator()
                                  : state is GetUserSuccess
                                  ? CustomText(
                                      text: "Hi, ${state.userModel.name} 👋",
                                      size: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.kDarkText,
                                    )
                                  : state is GetUserFailed
                                  ? CustomText(text: state.apiError.message!)
                                  : SizedBox.shrink();
                            },
                          ),
                          Gap(2.h),
                          CustomText(
                            text: "How are you feeling today?",
                            size: 13,
                            color: AppColors.kTextMuted,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/search-normal.svg",
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        Gap(4.w),
                      ],
                    ),
                    SliverToBoxAdapter(child: Gap(16.h)),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 148.h,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.kGradientStart,
                                      AppColors.kGradientEnd,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.kPrimary.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/images/girl.png",
                                height: 150.h,
                                width: 150.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 50.h,
                              left: 20.w,
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Book and schedule",
                                      color: Colors.white,
                                      size: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: "with nearest doctor",
                                      color: Colors.white.withOpacity(0.9),
                                      size: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12.h,
                              left: 20.w,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CustomText(
                                    text: "Find Nearby",
                                    color: AppColors.kPrimary,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: Gap(24.h)),
                    SliverPersistentHeader(
                      delegate: SpecialityHeaderDelegate(
                        minHeight: 100.h,
                        maxHeight: 100.h,
                        
                        child: Container(
                          color: AppColors.kBackGround,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Doctor Speciality",
                                      size: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.kDarkText,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllDoctorSpecialtyScreen(),
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text: "See all",
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(6.h),
                              SizedBox(
                                height: 70.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      SpecialityModel.specialityList.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        SpecialityModel.specialityList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (c) =>
                                                  AllDoctorsSpecialityListScreen(
                                                    specId: item.specialityID
                                                        .toString(),
                                                    title: item.specialityName,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: SpecialityWidget(item: item),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pinned: true,
                    ),

                    SliverToBoxAdapter(child: Gap(0.h)),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: CustomText(
                                text: "Recommendation Doctor",
                                size: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.kDarkText,
                                maxLines: 1,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllDoctorsScreen(),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: "See all",
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: doctorList.length,
                      itemBuilder: (context, index) {
                        final item = doctorList[index];
                        return CustomDoctorCardWidget(item: item);
                      },
                    ),
                    SliverToBoxAdapter(child: Gap(20.h)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
