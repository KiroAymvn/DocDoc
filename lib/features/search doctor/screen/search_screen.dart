import 'package:appointment/core/constant/app_colors.dart';
import 'package:appointment/features/search%20doctor/data/presentaion/search_doctor_cubit.dart';
import 'package:appointment/shared/custom_text.dart';
import 'package:appointment/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../home screen/widgets/custom_doctor_card_widget.dart';
import '../widgets/custom_doctor_card_widget.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBackGround,
        title: CustomText(text: "Search"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "search",
              isSearch: true,
              controller: context.read<SearchDoctorCubit>().searchController,
            ),
            BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SearchDoctorInitial) {
                  return Expanded(child: Center(child:  Lottie.asset("assets/lottie/search imm.json")));
                } else {
                  return state is SearchDoctorLoading
                      ? Center(child: Lottie.asset("assets/lottie/Trail_loading.json", height: 50.h))
                      : state is SearchDoctorSuccess && state.doctorList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.doctorList.length,
                            itemBuilder: (context, index) {
                              final item = state.doctorList[index];
                              return CustomDoctorCardWidget(item: item,);
                            },
                          ),
                        )
                      : state is SearchDoctorSuccess && state.doctorList.isEmpty
                      ? Expanded(
                        child: ListView(
                                            shrinkWrap: true,
                            children: [
                              Lottie.asset("assets/lottie/Empty List.json"),
                              CustomText(
                                text: "No doctor called ${context.read<SearchDoctorCubit>().searchController.text}",
                                alignment: AlignmentGeometry.center,
                              ),
                            ],
                          ),
                      )
                      : state is SearchDoctorFailed
                      ? Center(child: CustomText(text: state.errorMessage))
                      : SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
