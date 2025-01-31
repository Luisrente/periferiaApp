part of 'favoritemovies_cubit.dart';

abstract class FavoriteMoviesState extends Equatable {
  const FavoriteMoviesState();

  @override
  List<Object> get props => [];
}

class FavoriteMoviesInitial extends FavoriteMoviesState {}
class FavoriteMoviesError extends FavoriteMoviesState {
  String? message;
     FavoriteMoviesError(this.message);

}

class FavoriteMoviesUpdated extends FavoriteMoviesState {
  final Set<int> favoriteMovies;

  const FavoriteMoviesUpdated(this.favoriteMovies);

  @override
  List<Object> get props => [favoriteMovies];
}
