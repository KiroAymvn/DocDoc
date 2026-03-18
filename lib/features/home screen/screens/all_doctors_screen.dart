import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/all_doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_doctor_card_widget.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}


class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  @override
  void initState() {
    context.read<AllDoctorsCubit>().getAllDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "All Doctors",
            size: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.kDarkText,
            alignment: Alignment.center,
          ),
        ),
        body: BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
          builder: (context, state) {
            return  Skeletonizer(
              containersColor: AppColors.kLightGrey,
              effect: ShimmerEffect(baseColor: AppColors.kBorder),
              enabled: state is AllDoctorsLoading,
              child: state is AllDoctorsSuccess? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                itemCount: state.allDoctorsList.length,
                itemBuilder: (context, index) {
                  final item = state.allDoctorsList[index];
                  return CustomDoctorCardWidget(item: item);
                },
              ):SizedBox.shrink(),
            );
          },
        ));
  }
}
