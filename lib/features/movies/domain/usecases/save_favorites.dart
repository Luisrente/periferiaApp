
import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/error/failure.dart';
import 'package:periferiamovies/core/usecase/usecase.dart';
import 'package:periferiamovies/features/movies/domain/repositories/movies_repository.dart';

class SaveFavorites extends UseCase<void, Set<int>> {
  final MoviesRepository _repo;

  SaveFavorites(this._repo);

  @override
  Future<Either<Failure, void>> call(Set<int> favoriteIds) async {
    try {
      await _repo.saveFavorites(favoriteIds);  // Llamamos al repositorio para guardar los favoritos
      return Right(null);  // No necesitamos retornar nada en caso de éxito, solo un `void`
    } catch (e) {
      return Left(CacheFailure());  // Si ocurre algún error, retornamos un fallo
    }
  }
}

class GetFavorites extends UseCase<Set<int>, NoParams> {
  final MoviesRepository _repo;

  GetFavorites(this._repo);

  @override
  Future<Either<Failure, Set<int>>> call(NoParams params) {
    return _repo.getFavorites();
  }
}