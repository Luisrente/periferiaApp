import 'dart:convert';

import 'package:periferiamovies/features/auth/domain/entities/login.dart';

class LoginResponse {
    final String code;
    final String message;
    final int status;
    final Login data;

    LoginResponse({
        required this.code,
        required this.message,
        required this.status,
        required this.data,
    });

    LoginResponse copyWith({
        String? code,
        String? message,
        int? status,
        Login? data,
    }) => 
        LoginResponse(
            code: code ?? this.code,
            message: message ?? this.message,
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        data: Login.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}
