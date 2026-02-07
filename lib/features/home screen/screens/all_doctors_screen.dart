import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/home%20screen/data/presentation/all_doctors_cubit.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          title: CustomText(text: "All Doctors",alignment: AlignmentGeometry.center,textAlign: TextAlign.center,),
          backgroundColor: AppColors.kBackGround,
        ),
        body: BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
          builder: (context, state) {
            return  Skeletonizer(
              containersColor: AppColors.kGrey,
              effect: ShimmerEffect(baseColor: Colors.grey),
              enabled: state is AllDoctorsLoading,
              child: state is AllDoctorsSuccess? ListView.builder(
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
