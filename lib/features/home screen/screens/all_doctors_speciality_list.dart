import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/home%20screen/data/presentation/cubit/speciality_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/models/doctor_model.dart';
import '../widgets/custom_doctor_card_widget.dart';

class AllDoctorsSpecialityListScreen extends StatefulWidget {
  AllDoctorsSpecialityListScreen({super.key, required this.title, required this.specId});
  final String title;
  final String specId;
  @override
  State<AllDoctorsSpecialityListScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsSpecialityListScreen> {
  @override
  void initState() {
    context.read<SpecialityCubit>().getDoctorSpec(specID: widget.specId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.title,
          size: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kDarkText,
          alignment: Alignment.center,
        ),
      ),
      body: BlocBuilder<SpecialityCubit, SpecialityState>(
        builder: (context, state) {
          final isLoading = state is SpecialityLoading || state is SpecialityInitial;
          final doctorList = state is SpecialitySuccess
              ? state.homePageModel.doctorModelList ?? []
              : DoctorModel.docList;

          return Skeletonizer(
            containersColor: AppColors.kLightGrey,
            effect: ShimmerEffect(baseColor: AppColors.kBorder),
            enabled: isLoading,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                final item = doctorList[index];
                return CustomDoctorCardWidget(item: item);
              },
            ),
          );
        },
      ),
    );
  }
}
