import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/usecases/usecase.dart';
import '../repositories/login_repository.dart';

class Logout implements UseCase<bool, ParamsNot> {
  final LoginRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, bool>> call(ParamsNot params) async {
    return repository.logout();
  }
}

class ParamsNot extends Equatable {
  const ParamsNot();

  @override
  List<Object> get props => [];
}
