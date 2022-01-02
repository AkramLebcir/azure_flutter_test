import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/features/accounts_list/presentation/view/accounts_list_page.dart';
import 'core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'core/features/auth/presentation/view/auth_screen.dart';

class Shell extends StatefulWidget {
  const Shell({Key key}) : super(key: key);

  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return AccountsListPage();
        } else if (state is AuthenticationLoading) {
          return Center(child: const CircularProgressIndicator());
        }
        return AuthScreen();
      },
    );
  }
}
