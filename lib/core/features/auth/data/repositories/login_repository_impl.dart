import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/utils/error/exceptions.dart';
import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/network/network_info.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';

typedef Future<UserModel> _Login();
typedef Future<bool> _Logout();
typedef Future<UserModel> _GetUser();

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, UserModel>> login(LoginModel data) async {
    return await _login(() {
      return remoteDataSource.loginRemote(data);
    });
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    return await _logout(() {
      return remoteDataSource.logoutRemote();
    });
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    return await _getUser(() {
      return remoteDataSource.getCurrentUser();
    });
  }

  Future<Either<Failure, UserModel>> _login(
    _Login login,
  ) async {
    try {
      final remoteLogin = await login();
      return Right(remoteLogin);
    } on ServerException {
      return Left(const ServerFailure());
    }
  }

  Future<Either<Failure, bool>> _logout(
    _Logout logout,
  ) async {
    try {
      final remoteLogout = await logout();
      return Right(remoteLogout);
    } on ServerException {
      return Left(const ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> _getUser(
    _GetUser getUser,
  ) async {
    try {
      final remoteGetUser = await getUser();
      return Right(remoteGetUser);
    } on ServerException {
      return Left(const ServerFailure());
    }
  }
}
