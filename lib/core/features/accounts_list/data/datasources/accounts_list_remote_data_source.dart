import 'package:azure_test/core/features/accounts_list/domain/usecases/accounts_list.dart';
import 'package:flutter/widgets.dart';

import '../../../../../shared/utils/error/exceptions.dart';
import '../../../../../shared/utils/http_client.dart';
import '../models/accounts_list_model.dart';

abstract class AccountsListRemoteDataSource {
  Future<List<AccountsListModel>> getAccountsListRemote(Params params);
}

class AccountsListRemoteDataSourceImpl implements AccountsListRemoteDataSource {
  final HttpClient client;

  AccountsListRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<AccountsListModel>> getAccountsListRemote(Params params) =>
      getAccountsList(params);

  Future<List<AccountsListModel>> getAccountsList(Params params) async {
    String url = getUrl(params);

    final response = await client.dio.get(url);
    if (response.statusCode == 200) {
      return response.data['value']
          .map<AccountsListModel>((json) => AccountsListModel.fromMap(json))
          .toList();
    } else {
      print("ServerException");
      throw ServerException();
    }
  }

  getUrl(Params params) {
    String url =
        "https://org2c9fce96.crm4.dynamics.com/api/data/v9.0/accounts?\$select=accountnumber,name,statecode,address1_stateorprovince";

    if (params.search != null && params.search != '') {
      url = url +
          "&\$filter=(contains(accountnumber,'${params.search}') or contains(name,'${params.search}'))";
    }

    if (params.search != null &&
        params.search != '' &&
        params.stateCode != null) {
      url = url + "and statecode eq ${params.stateCode}";
    } else if (params.stateCode != null) {
      url = url + "&\$filter=statecode eq ${params.stateCode}";
    }

    if (((params.search != null && params.search != '') ||
            params.stateCode != null) &&
        (params.StateOrProvince != null && params.StateOrProvince != '')) {
      url = url + "and address1_stateorprovince eq '${params.StateOrProvince}'";
    } else if (params.StateOrProvince != null && params.StateOrProvince != '') {
      url = url +
          "&\$filter=address1_stateorprovince eq '${params.StateOrProvince}'";
    }

    return url;
  }
}
