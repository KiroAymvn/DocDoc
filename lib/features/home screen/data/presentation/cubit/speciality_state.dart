part of 'speciality_cubit.dart';

sealed class SpecialityState {}

final class SpecialityInitial extends SpecialityState {}

final class SpecialityLoading extends SpecialityState {}

final class SpecialitySuccess extends SpecialityState {
  HomePageModel homePageModel;
  SpecialitySuccess({required this.homePageModel});
}

final class SpecialityFailed extends SpecialityState {
  final String errorMessage;

  SpecialityFailed({required this.errorMessage});
}
