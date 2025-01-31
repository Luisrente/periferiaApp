import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:periferiamovies/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:periferiamovies/features/auth/domain/repositories/auth_repository.dart';
import 'package:periferiamovies/features/auth/domain/usecases/post_login.dart';
import 'package:periferiamovies/features/auth/presentation/blog/login/auth_bloc.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:periferiamovies/features/movies/data/datasources/local/movies_local_datasource.dart';
import 'package:periferiamovies/features/movies/domain/usecases/save_favorites.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/bloc/bloc/movies_bloc.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/internet/connection_status_cubit.dart';
import 'package:periferiamovies/features/movies/pages/movies/cubit/favoritemovies_cubit.dart';
import 'package:periferiamovies/utils/utils.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }
  sl.registerSingleton<DioClient>(DioClient(isUnitTest: isUnitTest));
    sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  _dataSources();
  _repositories();
  _useCase();
  _cubit();


  if (isHiveEnable) {
    await _initHiveBoxes(
      isUnitTest: isUnitTest,
      prefixBox: prefixBox,
    );
  }
}

Future<void> _initHiveBoxes({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainBoxMixin.initHive(prefixBox);
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {

  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(sl(),sl(),sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(),sl()));
}

/// Register dataSources
void _dataSources() {

  sl.registerLazySingleton<MoviesRemoteDatasource>(
    () => MoviesRemoteDatasourceImpl(sl()),
  );
   sl.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(sl()),
  );
   sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );

}

void _useCase() {
  /// Auth


  /// Users
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => SaveFavorites(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
}

void _cubit() {
  /// Auth

  sl.registerFactory(() => ConnectionStatusCubit());
  sl.registerFactory(() => FavoriteMoviesCubit(sl(),sl()));

  /// Users
  sl.registerFactory(() => AuthBlog(sl(),sl()));
  sl.registerFactory(() => MoviesBloc(sl()));
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => MainBlog());
}
