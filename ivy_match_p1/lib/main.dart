import 'package:flutter/material.dart';
import 'package:ivy_match_p1/Utils/utils.dart';
import 'package:ivy_match_p1/pages/addUser.dart';
import 'package:ivy_match_p1/pages/viewUsers.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'IvyMatch_P1',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(33,37,47,1),
        accentColor: Color.fromRGBO(75,84,91,1),
        primaryColor: Color.fromRGBO(33,37,47,1),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterLogo(
          size: 150,
        ),
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            child: Text("Add User",style: TextStyle(fontSize: 20),),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                )
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>AddUser())
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            child: Text("View Users",style: TextStyle(fontSize: 20),),
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                )
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>ViewUsers())
              );
            },
          ),
        ),
      ],
    )
  );
}

