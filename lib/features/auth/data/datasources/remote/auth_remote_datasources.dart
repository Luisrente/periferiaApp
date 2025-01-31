import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/auth.dart';


abstract class AuthRemoteDatasource {
  Future<Either<Failure,LoginResponse>> login(LoginParams loginParams);
 
} 

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  
  final DioClient _client;

  AuthRemoteDatasourceImpl(this._client);



  @override
  Future<Either<Failure,LoginResponse>> login(LoginParams loginParams) async {
    final response = await _client.postRequest(
      ListAPI.login,
      data:loginParams.toJson() ,
      converter: (response) =>
          LoginResponse.fromJson(response as Map<String, dynamic>),
    );

    return Right(LoginResponse(code: "",data: Login(token: "token", roles: ["roles"], usuario: "usuario"), message: '', status: 200));
  }
  

}


