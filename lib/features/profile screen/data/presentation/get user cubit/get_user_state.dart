part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}
final class GetUserLoading extends GetUserState {}
final class GetUserSuccess extends GetUserState {
  final UserModel userModel;
  GetUserSuccess({required this.userModel});
}
final class GetUserFailed extends GetUserState {
  final ApiError apiError;
  GetUserFailed({required this.apiError});

}
