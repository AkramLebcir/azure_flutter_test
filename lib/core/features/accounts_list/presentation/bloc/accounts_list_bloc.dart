import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/utils/error/failures.dart';
import '../../data/models/accounts_list_model.dart';
import '../../domain/usecases/accounts_list.dart';

part 'accounts_list_event.dart';
part 'accounts_list_state.dart';

class AccountsListBloc extends Bloc<AccountsListEvent, AccountsListState> {
  final GetAccountsList accounts_list;

  AccountsListBloc({@required this.accounts_list})
      : super(AccountsListInitial());

  @override
  Stream<AccountsListState> mapEventToState(
    AccountsListEvent event,
  ) async* {
    if (event is InitAccountsList) {
      yield* _mapAccountsListInitialToState(event);
    }
  }

  Stream<AccountsListState> _mapAccountsListInitialToState(
      InitAccountsList event) async* {
    try {
      yield AccountsListLoading();
      var resultAccountsList = await accounts_list(Params(
          search: event.search,
          stateCode: event.stateCode,
          StateOrProvince: event.StateOrProvince));
      yield resultAccountsList.fold(
        (failure) {
          return _mapFailureToMessage(failure);
        },
        (data) {
          return AccountsListSuccess(accountsListModel: data);
        },
      );
      return;
    } catch (e) {
      yield AccountsListError(message: e.toString());
    }
  }

  AccountsListState _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AccountsListError(message: 'ServerFailure');
      case CacheFailure:
        return AccountsListError(message: 'CacheFailure');
      default:
        return AccountsListError(message: 'Unexpected error');
    }
  }
}
