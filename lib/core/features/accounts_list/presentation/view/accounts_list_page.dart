import 'dart:math';

import 'package:azure_test/core/features/accounts_list/presentation/cubit/view/view_cubit.dart';
import 'package:azure_test/core/features/accounts_list/presentation/view/accounts_list_detail_page.dart';
import 'package:azure_test/core/features/accounts_list/presentation/widgets/item_account_card_widget.dart';
import 'package:azure_test/shared/common/styles/styles.dart';
import 'package:azure_test/shared/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../bloc/accounts_list_bloc.dart';
import '../widgets/item_account_widget.dart';
import 'filter_dialog.dart';

class AccountsListPage extends StatefulWidget {
  const AccountsListPage({Key key}) : super(key: key);

  @override
  _AccountsListPageState createState() => _AccountsListPageState();
}

class _AccountsListPageState extends State<AccountsListPage> {
  TextEditingController _controller;
  bool viewList = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<AccountsListBloc>().add(InitAccountsList());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.lightBGwhiteBar,
      appBar: AppBar(
        actions: [
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              context.read<AccountsListBloc>().add(InitAccountsList());
            },
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
            child: Icon(Icons.power_settings_new),
            onTap: () {
              context.read<AuthBloc>().add(UserLoggedOut());
            },
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Container(
        width: max(70.h, 400),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Search',
                      ),
                      onChanged: (value) {
                        context
                            .read<AccountsListBloc>()
                            .add(InitAccountsList(search: value));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        bool xx = await showDialog<bool>(
                          context: context,
                          builder: (contextDialog) {
                            return FilterDialog();
                          },
                        );
                        print(xx);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.filter_alt_rounded,
                          ),
                          Text("Filter"),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ViewCubit, view>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          context.read<ViewCubit>().toggleView();
                        },
                        child: Icon(
                          state == view.list
                              ? Icons.apps_rounded
                              : Icons.view_list_rounded,
                          size: state == view.list ? 23 : 26,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ViewCubit, view>(
                builder: (contextCubit, stateCubit) {
                  return BlocBuilder<AccountsListBloc, AccountsListState>(
                    builder: (context, state) {
                      if (state is AccountsListSuccess) {
                        if (stateCubit == view.list) {
                          return ListView.builder(
                            itemCount: state.accountsListModel.length,
                            itemBuilder: (context, index) {
                              return ItemAccountWidget(
                                click: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountsListDetailPage(
                                              accountsListModel: state
                                                  .accountsListModel[index],
                                            )),
                                  );
                                },
                                accountsListModel:
                                    state.accountsListModel[index],
                              );
                            },
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, mainAxisExtent: 180),
                                itemCount: state.accountsListModel.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemAccountCardWidget(
                                    click: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountsListDetailPage(
                                                  accountsListModel: state
                                                      .accountsListModel[index],
                                                )),
                                      );
                                    },
                                    accountsListModel:
                                        state.accountsListModel[index],
                                  );
                                }),
                          );
                        }
                      } else if (state is AccountsListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AccountsListError) {
                        return Center(
                          child: ErrorImage(),
                        );
                      } else {
                        return NoInternetWidget(
                            message: '',
                            onPressed: () {
                              context
                                  .read<AccountsListBloc>()
                                  .add(InitAccountsList());
                            });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
