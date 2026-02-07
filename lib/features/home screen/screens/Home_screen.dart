import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/constant/screen_size.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:appointment/features/home%20screen/data/presentation/home_cubit.dart';
import 'package:appointment/features/home%20screen/screens/all_doctor_speciality_screen.dart';
import 'package:appointment/features/home%20screen/screens/all_doctors_screen.dart';
import 'package:appointment/features/search%20doctor/screen/search_screen.dart';
import 'package:appointment/shared/custom_button.dart';
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
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.kBackGround,
                      title: Column(
                        children: [
                          BlocConsumer<GetUserCubit, GetUserState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              final cubit = context.read<GetUserCubit>();
                              return state is GetUserLoading
                                  ? CupertinoActivityIndicator()
                                  : state is GetUserSuccess
                                  ? CustomText(text: "Hi ${state.userModel.name}")
                                  : state is GetUserFailed
                                  ? CustomText(text: state.apiError.message!)
                                  : SizedBox.shrink();
                            },
                          ),
                          CustomText(text: "Are you okay ?", size: 15, color: AppColors.kGrey),
                        ],
                      ),
                      actions: [
                        Gap(10.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                          },
                          child: SvgPicture.asset("assets/icons/search-normal.svg"),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              height: 180.h,
                              decoration: BoxDecoration(color: Colors.transparent),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: AppColors.kPrimary,
                                borderRadius: BorderRadius.all(Radius.circular(12.r)),
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
                            top: 65.h,
                            left: 20.w,
                            child: SizedBox(
                              child: Column(
                                children: [
                                  CustomText(text: "Book and schedule ", color: Colors.white),
                                  CustomText(text: "with nearest doctor ", color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: -20.w,
                            child: Transform.scale(
                              scale: 0.7,
                              child: CustomButton(
                                onTap: () {},
                                text: "Find Nearby",
                                textSize: 15,
                                backGroundColor: Colors.white,
                                textColor: AppColors.kPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: Gap(20.h)),
                    SliverPersistentHeader(
                      delegate: SpecialityHeaderDelegate(
                        minHeight: 135.h,
                        maxHeight: 135.h,
                        child: Container(
                          color: AppColors.kBackGround, // مهم عشان مايبقاش Transparent
                          // padding: EdgeInsets.only(top: 2.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Doctor Speciality", color: Colors.black),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AllDoctorSpecialtyScreen()),
                                        );
                                      },
                                      child: CustomText(text: "see all", size: 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: SpecialityModel.specialityList.length,
                                  itemBuilder: (context, index) {
                                    final item = SpecialityModel.specialityList[index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                      child: SpecialityWidget(item: item),
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

                    //**********
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: CustomText(text: "Recommendation Doctor", color: Colors.black, maxLines: 1),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllDoctorsScreen()));
                              },
                              child: CustomText(text: "see all", size: 15),
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
