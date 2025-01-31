// movies_event.dart
part of 'movies_bloc.dart';

abstract class MoviesEvent {}

class FetchMoviesEvent extends MoviesEvent {
  final MoviesParams moviesParams;

  FetchMoviesEvent(this.moviesParams);
}

class FetchRefreshMoviesEvent extends MoviesEvent {
  final MoviesParams moviesParams;

  FetchRefreshMoviesEvent(this.moviesParams);
}

class ClearMoviesEvent extends MoviesEvent {}
