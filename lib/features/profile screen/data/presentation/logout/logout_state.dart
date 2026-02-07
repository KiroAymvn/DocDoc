part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {
}
final class LogoutFailed extends LogoutState {
  final String errorMess;
  final int? statuesCode;

  LogoutFailed({required this.errorMess,  this.statuesCode});


}
