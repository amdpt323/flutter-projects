import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle,)
      :SignupPage(onClickedSignIn: toggle,);

  void toggle() => setState(() {
    isLogin=!isLogin;
  });
}