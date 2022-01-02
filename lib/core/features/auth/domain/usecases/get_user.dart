import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../repositories/login_repository.dart';

class GetUser implements UseCase<UserModel, ParamsGetUser> {
  final LoginRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(ParamsGetUser params) async {
    return repository.getUser();
  }
}

class ParamsGetUser extends Equatable {
  ParamsGetUser();

  @override
  List<Object> get props => [];
}
