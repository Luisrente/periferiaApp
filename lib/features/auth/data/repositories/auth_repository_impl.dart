
import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/auth.dart';
import 'package:periferiamovies/utils/services/hive/hive.dart';
import 'package:periferiamovies/features/auth/data/datasources/remote/auth_remote_datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  final AuthRemoteDatasource authRemoteDatasource;
  final MainBoxMixin mainBoxMixin;

  const AuthRepositoryImpl(this.authRemoteDatasource, this.mainBoxMixin,);

  @override
  Future<Either<Failure,LoginResponse>> login(LoginParams loginParams) async {
    final response = await authRemoteDatasource.login(loginParams);
    return response.fold(
      (failure) => Left(failure),
      (loginResponse) {
        mainBoxMixin.addData(MainBoxKeys.isLogin, true);
        return Right(loginResponse);
      },
    );
  }

}
