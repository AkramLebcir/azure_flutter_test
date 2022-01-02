import 'package:azure_test/shared/common/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../data/models/accounts_list_model.dart';

class ItemAccountWidget extends StatelessWidget {
  final AccountsListModel accountsListModel;
  final Function click;
  const ItemAccountWidget({Key key, this.accountsListModel, this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Material(
          color: ColorPalettes.white,
          elevation: 1,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: ListTile(
            onTap: click,
            title: Text(this.accountsListModel.name ?? ''),
            leading: Icon(
              Icons.person_outline,
              size: 42,
            ),
            subtitle: Text(this.accountsListModel.accountnumber ?? ''),
          ),
        ));
  }
}
