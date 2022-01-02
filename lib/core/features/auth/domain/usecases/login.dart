import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/usecases/usecase.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_model.dart';
import '../repositories/login_repository.dart';

class Login implements UseCase<UserModel, Params> {
  final LoginRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(Params params) async {
    return repository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginModel login;

  Params({ @required this.login});

  @override
  List<Object> get props => [login];
}
