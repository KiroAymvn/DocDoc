import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/features/favorites/data/repo/favorites_repo.dart';
import 'package:bloc/bloc.dart';

part 'favorites_state.dart';

/// Manages favorite doctors state.
/// All data is stored locally in Hive — no network calls needed.
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    // Load favorites immediately when the cubit is created
    loadFavorites();
  }

  final FavoritesRepo _repo = FavoritesRepo();

  /// Loads all favorites from Hive and emits [FavoritesLoaded].
  void loadFavorites() {
    final favorites = _repo.getFavorites();
    emit(FavoritesLoaded(favorites: favorites));
  }

  /// Returns true if the given doctor is in favorites.
  bool isFavorite(int doctorId) => _repo.isFavorite(doctorId);

  /// Toggles the favorite status of a doctor.
  /// Returns true if added, false if removed.
  Future<bool> toggleFavorite(DoctorModel doctor) async {
    final wasAdded = await _repo.toggleFavorite(doctor);
    // Refresh the list after the change
    loadFavorites();
    return wasAdded;
  }
}
