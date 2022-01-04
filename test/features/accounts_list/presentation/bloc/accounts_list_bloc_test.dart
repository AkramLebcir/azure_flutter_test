import 'package:azure_test/core/features/accounts_list/data/models/accounts_list_model.dart';
import 'package:azure_test/core/features/accounts_list/domain/usecases/accounts_list.dart';
import 'package:azure_test/core/features/accounts_list/presentation/bloc/accounts_list_bloc.dart';
import 'package:azure_test/shared/utils/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetAccountsList extends Mock implements GetAccountsList {}

void main() {
  MockGetAccountsList mockGetAccountsList;

  setUp(() {
    mockGetAccountsList = MockGetAccountsList();
  });

  group('GetAccountsList', () {
    final tAccountsListModels = [
      AccountsListModel(
          accountnumber: '1',
          name: 'test 1',
          statecode: 0,
          address1_stateorprovince: 'TX'),
      AccountsListModel(
          accountnumber: '2',
          name: 'test 2',
          statecode: 0,
          address1_stateorprovince: 'TX'),
    ];

    blocTest(
      'emits [AccountsListLoading, AccountsListError] when unsuccessful',
      build: () {
        when(mockGetAccountsList.call(any)).thenThrow(ServerFailure());
        return AccountsListBloc(accounts_list: mockGetAccountsList);
      },
      act: (bloc) => bloc.add(InitAccountsList()),
      expect: [
        AccountsListLoading(),
        AccountsListError(message: "ServerFailure"),
      ],
    );

    blocTest(
      'emits [AccountsListLoading, AccountsListSuccess] when successful',
      build: () {
        when(mockGetAccountsList.call(any))
            .thenAnswer((_) async => Right(tAccountsListModels));
        return AccountsListBloc(accounts_list: mockGetAccountsList);
      },
      act: (bloc) => bloc.add(InitAccountsList()),
      expect: [
        AccountsListLoading(),
        AccountsListSuccess(accountsListModel: tAccountsListModels),
      ],
    );
  });
}
