import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/core/storage/hive_service.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/features/auth/screens/login_screen.dart';
import 'package:appointment/features/profile%20screen/data/repo/user_repo.dart';
import 'package:appointment/shared/custom_scaffold_messanger.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  ProfileRepo _profileRepo = ProfileRepo();

  Future<void> logout(BuildContext context) async {
    emit(LogoutLoading());

    try {
      await _profileRepo.logout();
      await PrefHelper.saveToken(null);
      await PrefHelper.saveLogged(false);
      
      // Clear all cached offline data
      await HiveService.clearAllBoxes();
      
      final isLogged= await PrefHelper.isLogged();
      print("logout success");
      print("$isLogged at cubit");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      scaffoldMessengerError(context, "Logged out Successfully",color: Colors.green);

      emit(LogoutSuccess());

    } catch (e) {
      if (e is ApiError) {
        emit(LogoutFailed(errorMess: e.message.toString()));
      } else {
        emit(LogoutFailed(errorMess: e.toString()));
      }
    }
  }
}
