import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/features/auth/data/repo/auth_repo.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../screens/login_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //SIGNUP CONTROLLER
  AuthRepo _authRepo = AuthRepo();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  int gender = 0;

  //Login CONTROLLER
  TextEditingController loginEmailController = TextEditingController(text: "123@gmail.com");
  TextEditingController loginPasswordController = TextEditingController(text: "passwordddd");

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String gender,
  }) async {
    emit(AuthLoading()); // نبدأ التحميل
    try {
      final data = await _authRepo.signUp(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        gender: gender,
      );

      emit(AuthSuccess(Token: data));
    } catch (e) {
      // هنا التغيير المهم: نستخدم catch عامة بدلاً من on DioException
      // لأن AuthRepo يرمي ApiError وليس DioException
      if (e is ApiError) {
        emit(AuthFailed(apiError: e));
      } else {
        rethrow;
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final data = await _authRepo.logIn(email: email, password: password);
      final String token = data["data"]["token"];
      await PrefHelper.saveToken(token);
      emit(AuthSuccess(Token: token));
      await PrefHelper.saveLogged(true);

    } catch (e) {
      if(e is ApiError){
        emit(AuthFailed(apiError: e));
      }else{
        throw Exception(e);
      }
    }
  }
}
