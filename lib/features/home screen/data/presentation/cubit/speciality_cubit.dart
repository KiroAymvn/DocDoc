import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:appointment/features/home%20screen/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'speciality_state.dart';

HomeRepo _homeRepo = HomeRepo();

class SpecialityCubit extends Cubit<SpecialityState> {
  SpecialityCubit() : super(SpecialityInitial());

  Future<void> getDoctorSpec({required String specID}) async {
    try {
      emit(SpecialityLoading());
      final data = await _homeRepo.getDoctorSpeciality(specId: specID);
      emit(SpecialitySuccess(homePageModel: data));
    } catch (e) {
      if (e is ApiError) {
        emit(SpecialityFailed(errorMessage: e.message.toString()));
      } else {
        emit(SpecialityFailed(errorMessage: e.toString()));
      }
    }
  }
}
