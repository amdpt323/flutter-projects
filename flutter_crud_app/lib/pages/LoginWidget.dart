import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/Utils.dart';
import 'forgotPass.dart';
import '../main.dart';

typedef voidCallback = void Function();




class LoginWidget extends StatefulWidget {
  final voidCallback onClickedSignUp;

  const LoginWidget({
    Key ? key,
    required this.onClickedSignUp,
  }):super(key:key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Login Page"),),
    body:SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 130,),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: TextField(
                controller: emailController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    label: Text("Email"),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: TextField(
                controller: passwordController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    label: Text("Password"),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50.0)
                ),
                icon: Icon(Icons.lock_open,size: 32.0),
                label: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24.0),
                ),
                onPressed: signIn,
              ),
            ),
            SizedBox(height: 24,),
            GestureDetector(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute
                (builder: (context)=>ForgotPasswordPage(),
              )),
            ),
            SizedBox(height: 16,),
            RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black,fontSize: 20),
                  text: 'No Account ?   ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          decoration: TextDecoration.underline
                      ),
                      text: 'Sign Up',
                    )
                  ]
                ),

            )
          ],
        ),
      ),
    ),
  );

  Future signIn() async {

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackbar(e.message);
    }


  }
}
