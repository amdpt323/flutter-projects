
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_crud_app/firebase_options.dart';
import 'package:flutter_crud_app/pages/AuthPage.dart';

import 'package:flutter_crud_app/Widgets/Utils.dart';
import 'package:flutter_crud_app/pages/verifyEmail.dart';






void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );runApp(MyApp());}

final navigatorKey = GlobalKey <NavigatorState> ();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(

    navigatorKey: navigatorKey,
    scaffoldMessengerKey: messengerKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,

    ),
    home: MainPage(),
  );
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text('Something went wrong'),);
        }else if(snapshot.hasData){
          return VerifyEmailPage();
        }else{
          return AuthPage();
        }

      },
    )
  );
}


