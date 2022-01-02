
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/common/utils/utils.dart';
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
        .post(UrlConstant.urlAuth, data: {
      'client_id': UrlConstant.client_id,
      'username': data.mail,
      'password': data.password,
      'grant_type': UrlConstant.grant_type,
      'resource': UrlConstant.resource
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
