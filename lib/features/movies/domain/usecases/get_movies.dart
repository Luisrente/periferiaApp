import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/movies.dart';


class GetMovies extends UseCase<List<Movie>, MoviesParams> {
  final MoviesRepository _repo;

  GetMovies(this._repo);

  @override
  Future<Either<Failure, List<Movie>>> call(MoviesParams params) =>
      _repo.getPopular(params);
}

class MoviesParams {
  final int? id;
  final int? page;

  MoviesParams({this.id, this.page});

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page': page,
    };
  }
}

