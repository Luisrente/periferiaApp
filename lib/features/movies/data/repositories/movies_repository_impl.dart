import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/movies/data/datasources/local/movies_local_datasource.dart';
import 'package:periferiamovies/features/movies/data/mappers/movie_mapper.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/movies.dart';

class MoviesRepositoryImpl implements MoviesRepository {

  /// Data Source
  final MoviesRemoteDatasource _moviesRemoteDatasource;
  final NetworkInfo networkInfo;
  final MoviesLocalDataSource _moviesLocalDataSource;

  const MoviesRepositoryImpl(this._moviesRemoteDatasource, this.networkInfo, this._moviesLocalDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getPopular(MoviesParams usersParams) async {
    

     if (await networkInfo.isConnected) {
      try {
        final response = await _moviesRemoteDatasource.getPopular(usersParams);

    return response.fold(
      (failure) => Left(failure),
      (r) async {
      _moviesLocalDataSource.savePopular(r);

    final List<Movie> movies = r.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();
    
        return Right(movies);
      },
    );
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      try {
        final local = await _moviesLocalDataSource.getPopular();
        final List<Movie> movies = local.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
  
 @override
  Future<Either<Failure, Set<int>>> getFavorites() async {
    try {
      final favorites = await _moviesLocalDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFavorites(Set<int> favoriteIds) async {
    try {
      await _moviesLocalDataSource.saveFavorites(favoriteIds);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
  
}
