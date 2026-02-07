import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/models/user_model.dart';

class AppointmentModel {
  final int id;
  final DoctorModel doctor;
  final UserModel patient;
  final String appointmentTime;
  final String appointmentEndTime;
  final String status;
  final String notes;
  final int appointmentPrice;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.notes,
    required this.appointmentPrice,
  });


  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as int,
      doctor: DoctorModel.fromMap(map["doctor"]),
      patient: UserModel.fromJson(map["patient"]),
      appointmentTime: map['appointment_time'] as String,
      appointmentEndTime: map['appointment_end_time'] as String,
      status: map['status'] as String,
      notes: map['notes'] as String,
      appointmentPrice: map['appointment_price'] as int,
    );
  }
}
