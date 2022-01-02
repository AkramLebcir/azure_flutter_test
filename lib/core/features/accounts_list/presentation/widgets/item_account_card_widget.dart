import 'package:azure_test/shared/common/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../data/models/accounts_list_model.dart';

class ItemAccountCardWidget extends StatelessWidget {
  final AccountsListModel accountsListModel;
  final Function click;
  const ItemAccountCardWidget({Key key, this.accountsListModel, this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        child: Material(
          color: ColorPalettes.white,
          elevation: 1,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: InkWell(
              onTap: click,
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
                    Spacer(),
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
        ));
  }
}
