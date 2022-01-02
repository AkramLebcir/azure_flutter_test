import 'package:azure_test/core/features/accounts_list/presentation/bloc/accounts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key key}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String stateOrProvince = "";
  int stateCode = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter'),
      content: SingleChildScrollView(
        child: BlocBuilder<AccountsListBloc, AccountsListState>(
          builder: (context, state) {
            if (state is AccountsListSuccess) {
              return Column(
                children: [
                  CheckboxListTile(
                      title: Text('State Code'),
                      value: stateCode == 0 ? false : true,
                      onChanged: (value) {
                        setState(() {
                          stateCode = value == true ? 1 : 0;
                        });
                      }),
                  Column(
                    children: state.accountsListModel
                        .toSet()
                        .map((e) => RadioListTile(
                              title: Text(e.address1_stateorprovince ?? ''),
                              value: e.address1_stateorprovince,
                              groupValue: stateOrProvince,
                              onChanged: (value) {
                                setState(() {
                                  stateOrProvince = value;
                                });
                              },
                            ))
                        .toSet()
                        .toList(),
                  )
                ],
              );
            } else {
              return Center(
                  child: Container(
                child: Text("data"),
              ));
            }
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('RESET'),
          onPressed: () {
            context.read<AccountsListBloc>().add(InitAccountsList());
            Navigator.of(context).pop();
            return false;
          },
        ),
        TextButton(
          child: const Text('FILTER'),
          onPressed: () {
            context.read<AccountsListBloc>().add(InitAccountsList(
                stateCode: stateCode, StateOrProvince: stateOrProvince));
            Navigator.of(context).pop();
            return true;
          },
        ),
      ],
    );
  }
}
