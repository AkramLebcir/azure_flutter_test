part of 'accounts_list_bloc.dart';

@immutable
abstract class AccountsListEvent {}

class InitAccountsList extends AccountsListEvent {
  final String search;
  final int stateCode;
  final String StateOrProvince;
  InitAccountsList({
    this.search,
    this.stateCode,
    this.StateOrProvince,
  });
}
