import 'package:fetch_movie_app/widgets/Utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fetch_movie_app/pages/authPage.dart';
import 'package:fetch_movie_app/pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    scaffoldMessengerKey: messengerKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor:  Color.fromRGBO(33,38,46,1),
      backgroundColor: Color.fromRGBO(33,38,46,1),
      colorScheme: ColorScheme(
        primary: Color.fromRGBO(75,83,91,1),  //defines primary
        secondary: Color.fromRGBO(33,38,46,1),
        surface: Color.fromRGBO(33,38,46,1),
        background: Color.fromRGBO(33,38,46,1),
        error: Color.fromRGBO(75,83,91,1),
        onPrimary: Color.fromRGBO(33,38,46,1),
        onSecondary: Color.fromRGBO(75,83,91,1),
        onSurface: Colors.grey,
        onBackground: Color.fromRGBO(33,38,46,1),
        onError: Color.fromRGBO(75,83,91,1),
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      )
    ),
    home:MainPage(),
  );
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return AuthPage();
        }
      },
    ),
  );
}
