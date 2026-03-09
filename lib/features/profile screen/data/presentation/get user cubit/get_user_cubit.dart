import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/core/network/api_error.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repo/user_repo.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  ProfileRepo _getUserRepo = ProfileRepo();

  Future<void> getUser() async {
    try {
      emit(GetUserLoading());
      final data = await _getUserRepo.getUserData();
      UserModel userModel = UserModel.fromJson(data);
      emit(GetUserSuccess(userModel: userModel));
    } catch (e) {
      if (e is ApiError) {
        emit(GetUserFailed(apiError: e));
      } else {
        emit(GetUserFailed(
          apiError: ApiError(message: e.toString()),
        ));
      }
    }
  }


  int gender = 0;

  Future<void> updateUser({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    try {
      emit(GetUserLoading());
      final UserModel user = await _getUserRepo.updateUserData(name: name, email: email, phone: phone, gender: gender,password:password);
      emit(GetUserSuccess(userModel: user));
    } catch (e) {
      if (e is ApiError) {
        emit(GetUserFailed(apiError: e));
      } else {
        emit(GetUserFailed(
          apiError: ApiError(message: e.toString()),
        ));
      }
    }
  }
}
