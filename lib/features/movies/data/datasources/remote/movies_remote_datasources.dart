import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/movies/data/mappers/movie_mapper.dart';
import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_response.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/movies.dart';

abstract class MoviesRemoteDatasource {
  Future<Either<Failure, MovieDbResponse>> getPopular(MoviesParams userParams);
}

class MoviesRemoteDatasourceImpl implements MoviesRemoteDatasource {
  final DioClient _client;

  MoviesRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, MovieDbResponse>> getPopular(MoviesParams userParams) async {
    final response = await _client.getRequest(
      ListAPI.getPopular,
      converter: (response) => MovieDbResponse.fromJson(response),
    );
    return response;
  }
}
