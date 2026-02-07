import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/models/speciality_model.dart';
import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/features/appointment/data/presentation/appointment_cubit.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: CustomText(text: "My Appointments", textAlign: TextAlign.center, alignment: AlignmentGeometry.center),
      ),
      body: Column(
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(color: AppColors.kPrimary),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(),
              indicatorColor: Colors.red,
              dividerColor: Colors.white,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              automaticIndicatorColorAdjustment: true,

              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(text: 'Upcoming'),

                // second tab [you can add an icon using the icon property]
                Tab(text: 'Completed'),
                Tab(text: 'Upcoming'),
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
                          padding: EdgeInsets.only(top: 20.h),
                          itemCount: 6, // عدد البطاقات الهيكلية التي تريد ظهورها
                          itemBuilder: (context, index) {
                            // هنا ننشئ موديل وهمي (Fake) مباشرة لغرض الرسم فقط
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
                        padding: EdgeInsets.only(top: 20.h),
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
                  child: Text('Buy Now', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                ),
                Center(
                  child: Text('Upcoming', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
