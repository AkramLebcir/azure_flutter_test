import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/features/auth/data/models/user_model.dart';
import '../../../core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../injection_container.dart';
import '../../common/common.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  AuthInterceptor(this.dio);

  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    final preferences = await SharedPreferences.getInstance();
    var userString = preferences.getString('user');
    if (userString != null &&
        userString != '' &&
        (!options.path.contains('oauth2/token'))) {
      UserModel user = UserModel.fromJson(userString.toString());
      DateTime expiryDate = Jwt.getExpiryDate(user.access_token);
      DateTime dateNow = DateTime.now().add(Duration(seconds: 10 * 60));

      print(dateNow.microsecondsSinceEpoch > expiryDate.microsecondsSinceEpoch);

      if (dateNow.microsecondsSinceEpoch > expiryDate.microsecondsSinceEpoch) {
        Dio().lock(); //   // Call the refresh endpoint to get a new token
        // await Dio().get("http://google.com").whenComplete(() => print("fin"));
        await Dio(BaseOptions(contentType: Headers.formUrlEncodedContentType))
            .post("https://login.microsoftonline.com/common/oauth2/token",
                data: {
              'client_id': UrlConstant.client_id,
              'username': UrlConstant.username,
              'password': UrlConstant.password,
              'grant_type': UrlConstant.grant_type,
              'resource': UrlConstant.resource,
              'refresh_token': user.refresh_token
            }).then((response) async {
          print(response.data);
          UserModel user = UserModel.fromMap(response.data);
          await preferences.setString('user', user.toJson());
        }).catchError((error, stackTrace) {
          print(error);
          Dio().unlock();
        }).whenComplete(() => Dio().unlock());
        // Dio().unlock();
      }

      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${user.access_token}';
    }

    if (options.path.contains('oauth2/token')) {
      options.headers[HttpHeaders.contentTypeHeader] =
          Headers.formUrlEncodedContentType;
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    log(response.toString());
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    await EasyLoading.showError("Error",
        dismissOnTap: true, duration: const Duration(milliseconds: 200));
    await EasyLoading.dismiss();
    if (err.response?.statusCode == 401) {
      inject<AuthBloc>().add(UserLoggedOut());
      // inject<Navigation>().navigateTo("/");
    }
    return super.onError(err);
  }
}
