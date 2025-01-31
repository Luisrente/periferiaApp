import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/core/error/failure.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/domain/usecases/get_movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMovies getMovies;

  MoviesBloc(this.getMovies) : super(const MoviesState()) {
    on<FetchMoviesEvent>(_fetchMoviesHandler);
    on<FetchRefreshMoviesEvent>(_fetchRefreshMoviesHandler);
    on<ClearMoviesEvent>(_clearHandler);
  }

  // Handler para limpiar las películas
  Future<void> _clearHandler(ClearMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(movies: []));
  }

  // Handler para obtener las películas
  Future<void> _fetchMoviesHandler(FetchMoviesEvent event, Emitter<MoviesState> emit) async {
    if (state.hasReachedMax) return;

    try {
      // Mostrar estado de carga
      emit(state.copyWith(status: MoviesStatus.loading));

      final data = await getMovies(event.moviesParams);
      data.fold(
        (l) {
          // Si ocurre un error, emite el estado de fallo
          if (l is ServerFailure) {
            emit(state.copyWith(status: MoviesStatus.failure, message: l.message));
          } else if (l is NoDataFailure) {
            emit(state.copyWith(status: MoviesStatus.empty));
          }
        },
        (r) {
          // Si la respuesta es exitosa, emite el estado con las películas obtenidas
          emit(state.copyWith(status: MoviesStatus.success, movies: r));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure, message: 'Something went wrong.'));
    }
  }

  Future<void> _fetchRefreshMoviesHandler(FetchRefreshMoviesEvent event, Emitter<MoviesState> emit) async {
    if (state.hasReachedMax) return;

    try {
      // Mostrar estado de carga

      final data = await getMovies(event.moviesParams);
      emit(state.copyWith(status: MoviesStatus.loading));

      data.fold(
        (l) {
          // Si ocurre un error, emite el estado de fallo
          if (l is ServerFailure) {
            emit(state.copyWith(status: MoviesStatus.failure, message: l.message));
          } else if (l is NoDataFailure) {
            emit(state.copyWith(status: MoviesStatus.empty));
          }
        },
        (r) {
          // Si la respuesta es exitosa, emite el estado con las películas obtenidas
          emit(state.copyWith(status: MoviesStatus.success, movies: r));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure, message: 'Something went wrong.'));
    }
  }
}
