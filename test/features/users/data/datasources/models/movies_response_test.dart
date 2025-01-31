import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:periferiamovies/features/movies/data/models/moviedb/movie_moviedb.dart';
import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_response.dart';

void main() {
  final movieDbResponse = MovieDbResponse(
    dates: Dates(
      maximum: DateTime(2024, 12, 31),
      minimum: DateTime(2024, 01, 01),
    ),
    page: 1,
    results: [
      MovieMovieDB(
        adult: false,
        backdropPath: "/backdrop_path.jpg",
        genreIds: [28, 12],
        id: 12345,
        originalLanguage: "en",
        originalTitle: "Movie Title",
        overview: "This is a movie overview.",
        popularity: 10.0,
        posterPath: "/poster_path.jpg",
        releaseDate: DateTime(2024, 08, 15),
        title: "Movie Title",
        video: false,
        voteAverage: 7.5,
        voteCount: 100,
      ),
    ],
    totalPages: 5,
    totalResults: 100,
  );

  // Test for fromJson
  test('fromJson should return a valid MovieDbResponse model from JSON', () {
    final jsonMap = json.decode('''
    {
      "dates": {
        "maximum": "2024-12-31",
        "minimum": "2024-01-01"
      },
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/backdrop_path.jpg",
          "genre_ids": [28, 12],
          "id": 12345,
          "original_language": "en",
          "original_title": "Movie Title",
          "overview": "This is a movie overview.",
          "popularity": 10.0,
          "poster_path": "/poster_path.jpg",
          "release_date": "2024-08-15",
          "title": "Movie Title",
          "video": false,
          "vote_average": 7.5,
          "vote_count": 100
        }
      ],
      "total_pages": 5,
      "total_results": 100
    }
    ''');

    final result = MovieDbResponse.fromJson(jsonMap as Map<String, dynamic>);

    expect(result, equals(movieDbResponse));
  });

  // Test for toJson
  test('toJson should return a valid JSON map from MovieDbResponse model', () {
    final result = movieDbResponse.toJson();

    final expectedJson = {
      "dates": {
        "maximum": "2024-12-31",
        "minimum": "2024-01-01",
      },
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/backdrop_path.jpg",
          "genre_ids": [28, 12],
          "id": 12345,
          "original_language": "en",
          "original_title": "Movie Title",
          "overview": "This is a movie overview.",
          "popularity": 10.0,
          "poster_path": "/poster_path.jpg",
          "release_date": "2024-08-15",
          "title": "Movie Title",
          "video": false,
          "vote_average": 7.5,
          "vote_count": 100,
        }
      ],
      "total_pages": 5,
      "total_results": 100,
    };

    expect(result, equals(expectedJson));
  });
}
