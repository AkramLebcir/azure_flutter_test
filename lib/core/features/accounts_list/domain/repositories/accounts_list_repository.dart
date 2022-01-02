import 'package:azure_test/core/features/accounts_list/domain/usecases/accounts_list.dart';
import 'package:dartz/dartz.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../data/models/accounts_list_model.dart';

abstract class AccountsListRepository {
  Future<Either<Failure, List<AccountsListModel>>> getAccountsList(
      Params params);
}
