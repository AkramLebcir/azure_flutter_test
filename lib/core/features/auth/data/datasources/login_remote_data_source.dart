import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/utils/error/exceptions.dart';
import '../../../../../shared/utils/http_client.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> loginRemote(LoginModel data);
  Future<bool> logoutRemote();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final HttpClient client;
  final SharedPreferences preferences;

  LoginRemoteDataSourceImpl(
      {@required this.client, @required this.preferences});

  @override
  Future<UserModel> loginRemote(LoginModel data) => login(data);

  @override
  Future<bool> logoutRemote() => logout();

  @override
  Future<UserModel> getCurrentUser() => getUser();

  Future<UserModel> login(LoginModel data) async {
    final response = await client.dio
        .post('https://login.microsoftonline.com/common/oauth2/token', data: {
      'client_id': '527744d2-f67d-4e42-aa67-b11a3b205234',
      'username': 'app@job1221.onmicrosoft.com',
      'password': 'RentReady21!',
      'grant_type': 'password',
      'resource': 'https://org2c9fce96.crm4.dynamics.com'
      // 'client_id': '9c241518-2f9d-4c6f-a0c8-da7d525cac83',
      // 'username': 'AkramLEBCIR@itsynergy210.onmicrosoft.com',
      // 'password': 'google12G\$',
      // 'grant_type': 'password',
      // 'resource': 'https://org95275b41.crm4.dynamics.com'
    });

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromMap(response.data);
      await preferences.setString('user', user.toJson());
      return user;
    } else {
      throw ServerException();
    }
  }

  Future<bool> logout() async {
    return await preferences.remove('user');
  }

  Future<UserModel> getUser() async {
    String userString = preferences.getString('user');
    UserModel user;
    if (userString != null && userString != '') {
      user = UserModel.fromJson(userString);
      return user;
    } else {
      return null;
    }
  }
}
