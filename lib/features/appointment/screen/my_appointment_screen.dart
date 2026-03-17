import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/models/speciality_model.dart';
import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../data/model/appointment_model.dart';
import '../widget/appointmet_card.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    context.read<AppointmentCubit>().getAppointment();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "My Appointments",
          size: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.kDarkText,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.kLightGrey,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.kPrimary,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.kTextMuted,
              labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                BlocConsumer<AppointmentCubit, AppointmentState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {

                    if (state is AppointmentLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 16.h),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return AppointmentCard(
                              appointmentModel: AppointmentModel(
                                id: 1,
                                doctor: DoctorModel(
                                  doctorId: 1,
                                  name: "name",
                                  email: "email",
                                  phone: "phone",
                                  gender: "gender",
                                  address: "address",
                                  description: "description",
                                  degree: "degree",
                                  specialization: SpecialityModel(specialityID: 1, specialityName: "specialityName"),
                                  appointPrice: 300,
                                  startTime: "startTime",
                                  endTime: "endTime",
                                ),
                                patient: UserModel(
                                  id: 1,
                                  name: "name",
                                  email: "email",
                                  phone: "phone",
                                  gender: "gender",
                                ),
                                appointmentTime: "appointmentTime",
                                appointmentEndTime: "appointmentEndTime",
                                status: "status",
                                notes: "notes",
                                appointmentPrice: 100,
                              ),
                            );
                          },
                        ),
                      );
                    }


                    if (state is GetAppointmentSuccess && state.appointmentModelList.isEmpty) {
                      return Center(child: Lottie.asset("assets/lottie/Empty List.json"));
                    }


                    if (state is GetAppointmentSuccess) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 16.h),
                        itemCount: state.appointmentModelList.length,
                        itemBuilder: (context, index) {
                          return AppointmentCard(appointmentModel: state.appointmentModelList[index]);
                        },
                      );
                    }


                    if (state is AppointmentFailed) {
                      return Center(child: CustomText(text: state.errorMessage));
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // second tab bar view widget
                Center(
                  child: CustomText(text: 'Completed', size: 18, fontWeight: FontWeight.w500, color: AppColors.kTextMuted, alignment: Alignment.center),
                ),
                Center(
                  child: CustomText(text: 'Cancelled', size: 18, fontWeight: FontWeight.w500, color: AppColors.kTextMuted, alignment: Alignment.center),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
