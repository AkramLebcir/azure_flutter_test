import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../injection_container.dart';

class ErrorInterceptor extends Interceptor implements DioError {
  @override
  Future onError(DioError err) async {
    log('ErrorInterceptor ' + err.toString());
    switch (err.type) {
      case DioErrorType.CANCEL:
        err.error = 'Request to API server was cancelled';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        err.error = 'Connection to API server timed out';
        break;
      case DioErrorType.DEFAULT:
        err.error =
            'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        err.error = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.SEND_TIMEOUT:
        err.error = 'Send timeout in connection with API server';
        break;
      case DioErrorType.RESPONSE:
        if (err.response.data != null) {
          if (err.response.statusCode == 404 && err.response.data is String) {
            err.error = '${err.response.statusCode} Page not found.';
          }
          if (err.response.statusCode == 406 && err.response.data is String) {
            err.error = '${err.response.statusCode} Page not found.';
          }
          if (err.response.statusCode == 500 && err.response.data is String) {
            err.error = '${err.response.statusCode} Internal server error.';
          }
          if (err.response.statusCode == 401) {
            err.error = 'Unauthenticated';
            await EasyLoading.dismiss();
            inject<AuthBloc>().add(UserLoggedOut());
            // SharedPreferences preferences =
            //     await SharedPreferences.getInstance();
            // await preferences.remove('user');
            // inject<Navigation>().navigateTo("/");
          }
          if (err.response.statusCode == 403) {
            err.error = 'Unauthorized';
            await EasyLoading.dismiss();
            inject<AuthBloc>().add(UserLoggedOut());
            // SharedPreferences preferences =
            //     await SharedPreferences.getInstance();
            // await preferences.remove('user');
            // inject<Navigation>().navigateTo("/");
          }
        } else {
          err.error =
              'Received invalid status code: ${err.response.statusCode}';
        }
        break;
    }
    return err.message;
  }

  @override
  var error;

  @override
  RequestOptions request;

  @override
  Response response;

  @override
  DioErrorType type;

  @override
  String get message => error;

  @override
  String toString() {
    return error;
  }
}
