part of 'accounts_list_bloc.dart';

@immutable
abstract class AccountsListState extends Equatable {
  const AccountsListState();

  @override
  List<Object> get props => [];
}

class AccountsListInitial extends AccountsListState {}

class AccountsListLoading extends AccountsListState {}

class AccountsListSuccess extends AccountsListState {
  final List<AccountsListModel> accountsListModel;
  const AccountsListSuccess({@required this.accountsListModel});
  @override
  List<Object> get props => [accountsListModel];
}

class AccountsListError extends AccountsListState {
  final String message;

  const AccountsListError({@required this.message});

  @override
  List<Object> get props => [message];
}
