part of 'search_doctor_cubit.dart';

@immutable
sealed class SearchDoctorState {}

final class SearchDoctorInitial extends SearchDoctorState {}
final class SearchDoctorLoading extends SearchDoctorState {}
final class SearchDoctorSuccess extends SearchDoctorState {
  final List <DoctorModel> doctorList;
  SearchDoctorSuccess({required this.doctorList});

}
final class SearchDoctorFailed extends SearchDoctorState {
  final String errorMessage;
  SearchDoctorFailed({required this.errorMessage});

}
