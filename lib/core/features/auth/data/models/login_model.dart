import 'package:meta/meta.dart';

class LoginModel {
  String mail;
  String password;

  LoginModel(
      {@required this.mail,
        @required this.password,
      });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      mail: json['mail'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail'] = this.mail;
    data['password'] = this.password;
    return data;
  }
}
