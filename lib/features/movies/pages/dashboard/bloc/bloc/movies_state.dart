part of 'movies_bloc.dart';


enum MoviesStatus { initial, loading, success, failure, empty }

class MoviesState extends Equatable {
  final List<Movie> movies;
  final MoviesStatus status;
  final String? message;
  final bool hasReachedMax;

  const MoviesState({
    this.movies = const [],
    this.status = MoviesStatus.initial,
    this.message,
    this.hasReachedMax = false,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    MoviesStatus? status,
    String? message,
    bool? hasReachedMax,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  
  @override
  List<Object?> get props => [movies, status, message, hasReachedMax];
}
