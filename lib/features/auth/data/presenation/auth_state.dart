part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
String ?Token ;
DoctorModel ?doctorModel;
AuthSuccess({this.Token});
}
final class AuthFailed  extends AuthState {
  final ApiError apiError;
AuthFailed({required this.apiError});
}
