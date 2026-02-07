import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/search%20doctor/data/repo/search_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'search_doctor_state.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  SearchDoctorCubit() : super(SearchDoctorInitial());
  SearchRepo _repo=SearchRepo();
  TextEditingController searchController=TextEditingController();

  Future<void> searchDoctor({required String doctorName})async{
    try{
      emit(SearchDoctorLoading());
      final doctorList=await _repo.searchDoctor(doctorName: doctorName);
      emit(SearchDoctorSuccess(doctorList: doctorList));
    }catch (e){
      if (e is ApiError){
        emit(SearchDoctorFailed(errorMessage: e.toString()));
      }
      else {
        emit(SearchDoctorFailed(errorMessage: "An error occurred "));

      }
    }
  }
}
