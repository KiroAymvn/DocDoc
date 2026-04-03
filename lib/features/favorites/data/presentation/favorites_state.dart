part of 'favorites_cubit.dart';

/// Base state for the favorites feature
abstract class FavoritesState {}

/// Initial state before anything has loaded
class FavoritesInitial extends FavoritesState {}

/// Emitted after loading or any add/remove operation
class FavoritesLoaded extends FavoritesState {
  final List<DoctorModel> favorites;
  FavoritesLoaded({required this.favorites});
}
