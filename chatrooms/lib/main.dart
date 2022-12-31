import 'package:chatrooms/pages/chatpage.dart';
import 'package:chatrooms/pages/homepage.dart';
import 'package:chatrooms/widgets/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Chatrooms',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(33,37,47,1),

        accentColor: Color.fromRGBO(75,84,91,1),
        primaryColor: Color.fromRGBO(33,37,47,1),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return chatpage();
        }else{
          return HomePage();
        }
      },
    ),
  );
}



