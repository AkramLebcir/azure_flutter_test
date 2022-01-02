import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../shared/common/common.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            // shrinkWrap: true,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              //   child: Image.asset("assets/icon/icon.png",height: 50.w, width: 50.w,),
              // ),
              Center(
                  child: Text(
                "Login",
                style: Themes.textStyleHeader1.copyWith(fontSize: 34),
              )),

              Container(
                width: max(25.h, 400),
                padding: const EdgeInsets.all(24.0),
                child: LoginForm(),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              // Center(
              //     child: Text(
              //   "Amen Tech",
              //   style: Themes.textStyleContent,
              // )),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
