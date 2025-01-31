import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/domain/usecases/post_login.dart';
import 'package:periferiamovies/utils/enums.dart';
import 'package:periferiamovies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBlog extends Bloc<AuthEvent, AuthState> {
  AuthBlog(this._postLogin, this.mainBoxMixin ) : super(const AuthState()) {
    on<LoginEvent>(_handlerlogin);
  }

  final PostLogin _postLogin;
  final MainBoxMixin mainBoxMixin;

  bool? isPasswordHide = true;

  Future<void> _handlerlogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final data = await _postLogin.call(event.params);
    data.fold((l) {
      emit(state.copyWith(status: Status.error, message: (l is ServerFailure) ? l.message : "Error"));
    }, (r) {
      AppRoute.router.go(Routes.dashboard.path);
      emit(state.copyWith(status: Status.success, isLogin: true));
    });
  }

 
  Future<void> logout() async {
    await MainBoxMixin().logoutBox();
    AppRoute.router.go(Routes.login.path);
  }
}
