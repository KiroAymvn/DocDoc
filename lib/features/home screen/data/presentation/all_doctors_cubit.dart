import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/home%20screen/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_doctors_state.dart';

class AllDoctorsCubit extends Cubit<AllDoctorsState> {
  AllDoctorsCubit() : super(AllDoctorsInitial());
  HomeRepo _repo=HomeRepo();
  Future<void>getAllDoctors()async{
    try{
      emit(AllDoctorsLoading());
      final List<DoctorModel>allDoctorsList=await  _repo.getAllDoctors();
      emit(AllDoctorsSuccess(allDoctorsList: allDoctorsList));
    }catch(e){
      if(e is ApiError){
        emit(AllDoctorsFailed(errorMessage: e.toString()));
      }else{
        emit(AllDoctorsFailed(errorMessage: e.toString()));

      }
    }
  }
}
