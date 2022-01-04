import 'dart:math';

import 'package:azure_test/core/features/accounts_list/data/models/accounts_list_model.dart';
import 'package:azure_test/shared/common/common.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountsListDetailPage extends StatelessWidget {
  final AccountsListModel accountsListModel;
  const AccountsListDetailPage({Key key, this.accountsListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.lightBGwhiteBar,
      appBar: AppBar(
        title: Text(this.accountsListModel.name ?? 'Detail'),
        centerTitle: true,
      ),
      body: Container(
          width: max(70.h, 400),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 42,
                  color: ColorPalettes.grey,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  this.accountsListModel.name ?? '',
                  textAlign: TextAlign.center,
                  style: Themes.textInputeStyleTitle,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  this.accountsListModel.accountnumber ?? '',
                  textAlign: TextAlign.center,
                  style: Themes.textInputeStyleContent2,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
    );
  }
}
