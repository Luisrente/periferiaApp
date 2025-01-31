import 'dart:convert';

import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_response.dart';

import '../../../../../helpers/fake_path_provider_platform.dart';
import '../../../../../helpers/json_reader.dart';
import '../../../../../helpers/paths.dart';

void main() {
  late DioAdapter dioAdapter;
  late MoviesRemoteDatasourceImpl dataSource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    PathProviderPlatform.instance = FakePathProvider();
    await serviceLocator(
      isUnitTest: true,
      prefixBox: 'movies_remote_datasource_test_',
    );
    dioAdapter = DioAdapter(dio: sl<DioClient>().dio);
    dataSource = MoviesRemoteDatasourceImpl(sl<DioClient>());
  });

  group('movies', () {
    final moviesParams = MoviesParams();
    final moviesModel = MovieDbResponse.fromJson(
      json.decode(jsonReader(successMoviesPath)) as Map<String, dynamic>,
    );
    final moviesEmptyModel = MovieDbResponse.fromJson(
      json.decode(jsonReader(emptyMoviesPath)) as Map<String, dynamic>,
    );

    test(
      'should return list movies success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onGet(
          ListAPI.getPopular,
          (server) => server.reply(
            200,
            json.decode(jsonReader(successMoviesPath)),
          ),
          queryParameters: moviesParams.toJson(),
        );

        /// act
        final result = await dataSource.getPopular(moviesParams);

        /// assert
        result.fold(
          (l) => expect(l, null),
          (r) => expect(r, moviesModel),
        );
      },
    );

    test(
      'should return empty list movies success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onGet(
          ListAPI.getPopular,
          (server) => server.reply(
            200,
            json.decode(jsonReader(emptyMoviesPath)),
          ),
          queryParameters: moviesParams.toJson(),
        );

        /// act
        final result = await dataSource.getPopular(moviesParams);

        /// assert
        result.fold(
          (l) => expect(l, null),
          (r) => expect(r, moviesEmptyModel),
        );
      },
    );

    test(
      'should return movies unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onGet(
          ListAPI.getPopular,
          (server) => server.reply(
            400,
            json.decode(jsonReader(successMoviesPath)),
          ),
          queryParameters: moviesParams.toJson(),
        );

        /// act
        final result = await dataSource.getPopular(moviesParams);

        /// assert
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => expect(r, null),
        );
      },
    );
  });
}
