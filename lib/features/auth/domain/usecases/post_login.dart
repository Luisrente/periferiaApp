import 'package:dartz/dartz.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/data/models/login_response.dart';
import 'package:periferiamovies/features/auth/domain/repositories/auth_repository.dart';
import 'dart:convert';


class PostLogin extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository _repo;

  PostLogin(this._repo);

  @override
 Future<Either<Failure,LoginResponse>> call(LoginParams params) =>
      _repo.login(params);
}


class LoginParams {
    final int identificacion;
    final String clave;

    LoginParams({
        required this.identificacion,
        required this.clave,
    });

    LoginParams copyWith({
        int? identificacion,
        String? clave,
    }) => 
        LoginParams(
            identificacion: identificacion ?? this.identificacion,
            clave: clave ?? this.clave,
        );

    factory LoginParams.fromRawJson(String str) => LoginParams.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        identificacion: json["identificacion"],
        clave: json["clave"],
    );

    Map<String, dynamic> toJson() => {
        "identificacion": identificacion,
        "clave": clave,
    };
}

