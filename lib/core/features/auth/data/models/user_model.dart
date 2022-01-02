import 'dart:convert';

class UserModel {
  String access_token;
  String refresh_token;
  
  UserModel({
    this.access_token,
    this.refresh_token,
  });


  UserModel copyWith({
    String access_token,
    String refresh_token,
  }) {
    return UserModel(
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'refresh_token': refresh_token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      access_token: map['access_token'] ?? '',
      refresh_token: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(access_token: $access_token, refresh_token: $refresh_token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.access_token == access_token &&
      other.refresh_token == refresh_token;
  }

  @override
  int get hashCode => access_token.hashCode ^ refresh_token.hashCode;
}
