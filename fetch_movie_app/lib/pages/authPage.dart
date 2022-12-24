
import 'package:fetch_movie_app/widgets/LoginPage.dart';
import 'package:fetch_movie_app/widgets/SignupPage.dart';
import 'package:flutter/material.dart';


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
