
import 'dart:convert';

class Login {
    final String token;
    final List<String> roles;
    final String usuario;

    Login({
        required this.token,
        required this.roles,
        required this.usuario,
    });

    Login copyWith({
        String? sessionToken,
        List<String>? roles,
        String? usuario,
    }) => 
        Login(
            token: sessionToken ?? this.token,
            roles: roles ?? this.roles,
            usuario: usuario ?? this.usuario,
        );

    factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["sessionToken"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "sessionToken": token,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "usuario": usuario,
    };
}
