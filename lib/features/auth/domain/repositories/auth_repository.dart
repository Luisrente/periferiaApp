
import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/error/failure.dart';
import 'package:periferiamovies/features/auth/auth.dart';


abstract class AuthRepository {
  Future<Either<Failure,LoginResponse>> login(LoginParams loginParams);

}
