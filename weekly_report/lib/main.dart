import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weekly_report/pages/homepage.dart';
import 'package:weekly_report/pages/settings.dart';
import 'package:weekly_report/pages/taskPage.dart';
import 'package:weekly_report/pages/authPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weekly_report/utils/Utils.dart';
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
          return MyHomePage();
        }else{
          return AuthPage();
        }
      },
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    TaskPage(),
    Center(child:Text('insights')),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) =>Scaffold(
    body: tabs[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      selectedIconTheme: IconThemeData(color: Colors.amber),
      unselectedIconTheme: IconThemeData(color: Colors.white),
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          backgroundColor: Color.fromRGBO(29,28,33,1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Task',
          backgroundColor: Color.fromRGBO(29,28,33,1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_sharp),
          label: 'Insights',
          backgroundColor: Color.fromRGBO(29,28,33,1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Color.fromRGBO(29,28,33,1),
        ),
      ],
      onTap: (index){
        setState(() {
          _currentIndex=index;
        });
      },
    ),
  );
}

