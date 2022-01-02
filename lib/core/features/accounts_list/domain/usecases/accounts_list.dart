import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/usecases/usecase.dart';
import '../../data/models/accounts_list_model.dart';
import '../repositories/accounts_list_repository.dart';

class GetAccountsList implements UseCase<List<AccountsListModel>, Params> {
  final AccountsListRepository repository;

  GetAccountsList(this.repository);

  @override
  Future<Either<Failure, List<AccountsListModel>>> call(Params params) async {
    return repository.getAccountsList(params);
  }
}

class Params extends Equatable {
  final String search;
  final int stateCode;
  final String StateOrProvince;
  Params({this.search, this.stateCode, this.StateOrProvince});

  @override
  List<Object> get props => [search];
}
