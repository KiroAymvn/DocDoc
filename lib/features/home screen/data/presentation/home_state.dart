part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
  final List<HomePageModel> homeDataList;
  HomeSuccess({required this.homeDataList});
}
final class HomeFailed extends HomeState {
  final String errorMessage;
  HomeFailed({required this.errorMessage});

}
