import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/common/common.dart';
import '../../data/models/login_model.dart';
import '../bloc/auth/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm();
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    _phoneController.text = "akramlebcir@gmail.com";
    _passwordController.text = "Azerty@123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
              hintText: "email",
              errorText: " " == "" ? 'invalid email' : null,
              filled: true,
              isDense: true,
            ),
            onChanged: (username) => null,
            controller: _phoneController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty) {
                return "email required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
              hintText: "password",
              errorText: " " == "" ? 'invalid password' : null,
              filled: true,
              isDense: true,
            ),
            onChanged: (password) => null,
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return "password required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 31,
          ),
          RaisedButton(
              color: ColorPalettes.lightAccent,
              textColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child:
                  Text("login", style: Theme.of(context).textTheme.bodyText1),
              onPressed: () async {
                context.read<AuthBloc>().add(UserLoggedIn(
                    user: LoginModel(
                        mail: _phoneController.text,
                        password: _passwordController.text)));
              })
        ],
      ),
    );
  }
}
