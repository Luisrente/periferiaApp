import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:periferiamovies/core/usecase/usecase.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/domain/usecases/save_favorites.dart';

part 'favoritemovies_state.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  final SaveFavorites saveFavoritesUseCase;
  final GetFavorites getFavoritesUseCase;

  FavoriteMoviesCubit(this.saveFavoritesUseCase, this.getFavoritesUseCase) : super(FavoriteMoviesInitial()) {
    loadFavorites();  // Cargamos los favoritos al iniciar
  }

  final Set<int> _favoriteMovies = {};  // Usamos un Set para evitar duplicados

  Future<void> loadFavorites() async {
    final result = await getFavoritesUseCase.call(NoParams());

    result.fold(
      (failure) {
        emit(FavoriteMoviesError("Failed to load favorites"));
      },
      (favorites) {
        _favoriteMovies.addAll(favorites);
        emit(FavoriteMoviesUpdated(Set.from(_favoriteMovies)));  // Emitimos estado actualizado
      },
    );
  }

  void toggleFavorite(Movie movie) async {
    if (_favoriteMovies.contains(movie.id)) {
      _favoriteMovies.remove(movie.id);
    } else {
      _favoriteMovies.add(movie.id);
    }

    emit(FavoriteMoviesUpdated(Set.from(_favoriteMovies)));

    final result = await saveFavoritesUseCase(_favoriteMovies);
    result.fold(
      (failure) {
        emit(FavoriteMoviesError("Failed to save favorites"));
      },
      (_) {},
    );
  }

  bool isFavorite(int movieId) {
    return _favoriteMovies.contains(movieId);
  }
}