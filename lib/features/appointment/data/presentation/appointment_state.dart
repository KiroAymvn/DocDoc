part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}
final class AppointmentLoading extends AppointmentState {}
final class AppointmentDateChangedState extends AppointmentState {}
final class AppointmentSuccess extends AppointmentState {
  final AppointmentModel appointmentModel;

  AppointmentSuccess({required this.appointmentModel});

}
final class GetAppointmentSuccess extends AppointmentState {
  final List<AppointmentModel> appointmentModelList;

  GetAppointmentSuccess({required this.appointmentModelList});


}
final class AppointmentFailed extends AppointmentState {
  final String errorMessage;

  AppointmentFailed({required this.errorMessage});
}
