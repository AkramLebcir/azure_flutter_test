import 'package:azure_test/core/features/accounts_list/domain/usecases/accounts_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../../../../../shared/utils/error/exceptions.dart';
import '../../../../../shared/utils/error/failures.dart';
import '../../../../../shared/utils/network/network_info.dart';
import '../../domain/repositories/accounts_list_repository.dart';
import '../datasources/accounts_list_remote_data_source.dart';
import '../models/accounts_list_model.dart';

typedef Future<List<AccountsListModel>> _AccountsList();

class AccountsListRepositoryImpl implements AccountsListRepository {
  final AccountsListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AccountsListRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AccountsListModel>>> getAccountsList(
      Params params) async {
    return await _getAccountsList(() {
      return remoteDataSource.getAccountsListRemote(params);
    });
  }

  Future<Either<Failure, List<AccountsListModel>>> _getAccountsList(
    _AccountsList getAccountsList,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAccountsList = await getAccountsList();
        return Right(remoteAccountsList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
