import 'dart:developer';
import 'dart:io';

import 'package:azure_test/core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/features/auth/data/models/user_model.dart';
import '../../../injection_container.dart';
import '../../common/common.dart';
import '../http_client.dart' as http_client;

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
              'client_id': '527744d2-f67d-4e42-aa67-b11a3b205234',
              'username': 'app@job1221.onmicrosoft.com',
              'password': 'RentReady21!',
              'grant_type': 'refresh_token',
              'resource': 'https://org2c9fce96.crm4.dynamics.com',
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

    options.headers['Access-Control-Allow-Origin'] = '*';
    options.headers['Cross-Origin-Resource-Policy'] = 'cross-origin';
    options.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS';

    options.headers['Access-Control-Allow-Headers'] =
        'custId, appId, Origin, Content-Type, Cookie, X-CSRF-TOKEN, Accept, Authorization, X-XSRF-TOKEN, Access-Control-Allow-Origin';
    options.headers['Access-Control-Expose-Headers'] =
        'Authorization, authenticated';
    options.headers['Access-Control-Max-Age'] = '1728000';
    options.headers['Access-Control-Allow-Credentials'] = 'true';

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
      inject<Navigation>().navigateTo("/");
    }
    return super.onError(err);
  }
}
