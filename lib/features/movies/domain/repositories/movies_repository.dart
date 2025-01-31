import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/movies.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getPopular(MoviesParams usersParams);
 Future<Either<Failure, void>> saveFavorites(Set<int> favoriteIds);
  Future<Either<Failure, Set<int>>> getFavorites();  // Nuevo método

}
