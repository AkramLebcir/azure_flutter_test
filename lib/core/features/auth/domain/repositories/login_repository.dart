import 'package:dartz/dartz.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> login(LoginModel data);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserModel>> getUser();
}