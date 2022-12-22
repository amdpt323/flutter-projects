 import 'package:flutter/cupertino.dart';
import 'package:flutter_crud_app/pages/LoginWidget.dart';
import 'package:flutter_crud_app/pages/SignUpWidget.dart';

class AuthPage extends StatefulWidget {
   const AuthPage({Key? key}) : super(key: key);
 
   @override
   State<AuthPage> createState() => _AuthPageState();
 }
 
 class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
   @override
   Widget build(BuildContext context) => isLogin
       ? LoginWidget(onClickedSignUp: toggle,)
       : SignUpWidget(onClickedSignIn:toggle,);

   void toggle() => setState(() {
     isLogin = !isLogin;
   });
 }
 