part of 'all_doctors_cubit.dart';

@immutable
sealed class AllDoctorsState {}

final class AllDoctorsInitial extends AllDoctorsState {}
final class AllDoctorsLoading extends AllDoctorsState {}
final class AllDoctorsSuccess extends AllDoctorsState {
  final List <DoctorModel> allDoctorsList;
  AllDoctorsSuccess({required this.allDoctorsList});
}
final class AllDoctorsFailed extends AllDoctorsState {
  final String errorMessage;

  AllDoctorsFailed({required this.errorMessage});

}
