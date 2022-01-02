part of 'accounts_list_bloc.dart';

@immutable
abstract class AccountsListState {}

class AccountsListInitial extends AccountsListState {}

class AccountsListLoading extends AccountsListState {}

class AccountsListSuccess extends AccountsListState {
  final List<AccountsListModel> accountsListModel;
  AccountsListSuccess({@required this.accountsListModel});
  @override
  List<Object> get props => [accountsListModel];
}

class AccountsListError extends AccountsListState {
  final String message;

  AccountsListError({@required this.message});

  @override
  List<Object> get props => [message];
}
