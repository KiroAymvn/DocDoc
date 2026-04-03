import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';
import 'package:appointment/features/appointment/data/repo/appointment_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());
  AppointmentRepo _repo = AppointmentRepo();
 int appointmentCount=0;
  EasyDatePickerController controller = EasyDatePickerController();
  DateTime? dateTime = DateTime.now();

  TimeOfDay? timeOfDay = TimeOfDay.now();
  TextEditingController notesController = TextEditingController();

  void changeDate(DateTime date) {
    dateTime = date;
    emit(AppointmentDateChangedState()); // هذا السطر هو الذي يحدث الواجهة
  }

  void changeTime(TimeOfDay time) {
    timeOfDay = time;
    emit(AppointmentDateChangedState()); // هذا السطر هو الذي يحدث الواجهة
  }

  String formatTime24H(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> postAppointment({
    required String doctorId,
    required String startDate,
    String? notes,
    required BuildContext context,
  }) async {
    try {
      emit(AppointmentLoading());
      final data = await _repo.postAppointment(doctorId: doctorId, startDate: startDate, notes: notes);
      appointmentCount=appointmentCount+1;
      emit(AppointmentSuccess(appointmentModel: data));
    } catch (e) {
      if (e is ApiError) {
        emit(AppointmentFailed(errorMessage: e.message.toString()));
      } else {
        emit(AppointmentFailed(errorMessage: e.toString()));
      }
    }
  }

  Future<List<AppointmentModel>?> getAppointment() async {
    try {
      emit(AppointmentLoading());
      final appointmentList = await _repo.getAppointment();
      emit(GetAppointmentSuccess(appointmentModelList: appointmentList));
      return appointmentList;
    } catch (e) {
      if (e is ApiError) {
        emit(AppointmentFailed(errorMessage: e.message.toString()));
      } else {
        emit(AppointmentFailed(errorMessage: e.toString()));
      }
      return null;
    }
  }
}
