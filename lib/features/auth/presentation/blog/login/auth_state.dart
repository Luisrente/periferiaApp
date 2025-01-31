part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status status;
  final bool isLogin;
  final String message;

  const AuthState({this.status = Status.initial,this.message = '', this.isLogin = false});

  AuthState copyWith({Status? status, 
  String? message,
  bool? isLogin}) => AuthState(
      message: message ?? this.message,
      status: status ?? this.status, isLogin: isLogin ?? this.isLogin);

  @override
  List<Object> get props => [status, isLogin,message];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

// class AuthSuccess extends AuthState {
//   final LoginResponse? data;
//   const AuthSuccess(this.data);
// }

// class AuthLogout extends AuthState {
//   final String? data;
//   const AuthLogout(this.data);
// }

// class AuthFailure extends AuthState {
//   final String? message;
//   const AuthFailure(this.message);
// }

// class AuthInitial extends AuthState {}
