import 'dart:convert';

import 'package:periferiamovies/core/error/exceptions.dart';
import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_response.dart';
import 'package:periferiamovies/utils/services/hive/main_box.dart';

abstract class MoviesLocalDataSource {
  Future<MovieDbResponse> getPopular();
  Future<void> savePopular(MovieDbResponse params);
  Future<void> saveFavorites(Set<int> favoriteIds);
    Future<Set<int>> getFavorites();  // Nuevo método

}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final MainBoxMixin mainBoxMixin;

  MoviesLocalDataSourceImpl(this.mainBoxMixin);

  @override
  Future<MovieDbResponse> getPopular() {
    final jsonString = mainBoxMixin.getData(MainBoxKeys.getPopular);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return Future.value(MovieDbResponse.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> savePopular(MovieDbResponse params) {
    return mainBoxMixin.addData(
      MainBoxKeys.getPopular,
      jsonEncode(params.toJson()),
    );
  }

  @override
  Future<void> saveFavorites(Set<int> favoriteIds) {
    return mainBoxMixin.addData(
      MainBoxKeys.getFavorites,
      jsonEncode(
          favoriteIds.toList()), // Convertimos el Set a List antes de guardarlo
    );
  }
   @override
  Future<Set<int>> getFavorites() async {
    final jsonString = mainBoxMixin.getData(MainBoxKeys.getFavorites);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return Future.value(jsonList.cast<int>().toSet());  // Convertimos la lista en un Set<int>
    } else {
      return Future.value({});  // Devolvemos un conjunto vacío si no hay datos
    }
  }
  
}
