import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../../shared/utils/error/failures.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/get_user.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUser getUser;
  final Login login;
  final Logout logout;

  AuthBloc({this.getUser, this.login, this.logout}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      var resultGetUser = await getUser(ParamsGetUser());
      yield resultGetUser.fold(
        (failure) {
          log('_mapAppLoadedToState failure ' + failure.message);
          return AuthenticationNotAuthenticated();
        },
        (data) {
          if (data != null) {
            return AuthenticationAuthenticated(user: data);
          } else {
            return AuthenticationNotAuthenticated();
          }
        },
      );
      return;
    } catch (e) {
      log('_mapAppLoadedToState catch ' + e.toString());
      yield AuthenticationFailure(
          message: e.toString() ?? 'An unknown error occurred');
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationLoading();
    try {
      var resultLogin = await login(Params(
          login: LoginModel(
              mail: event.user.mail, password: event.user.password)));
      yield resultLogin.fold(
        (failure) {
          return _mapFailureToMessage(failure);
        },
        (data) {
          return AuthenticationAuthenticated(user: data);
        },
      );
      return;
    } catch (e) {
      log('_mapLoginToState catch ' + e.toString());
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    yield AuthenticationLoading();
    try {
      var resultLogout = await logout(ParamsNot());
      yield resultLogout.fold(
        (failure) {
          log('_mapUserLoggedOutToState failure ');
          return _mapFailureToMessage(failure);
        },
        (data) {
          log('_mapUserLoggedOutToState success');
          return AuthenticationNotAuthenticated();
        },
      );
      return;
    } catch (e) {
      log('_mapAppLoadedToState catch ' + e.toString());
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  AuthState _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const AuthenticationFailure(message: 'ServerFailure');
      case CacheFailure:
        return const AuthenticationFailure(message: 'CacheFailure');
      default:
        return const AuthenticationFailure(message: 'Unexpected error');
    }
  }
}
