import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_crud_app/Widgets/Utils.dart';

import '../main.dart';

typedef voidCallback = void Function();


class SignUpWidget extends StatefulWidget {
  final voidCallback onClickedSignIn;

  const SignUpWidget({
    Key ? key,
    required this.onClickedSignIn,
  }):super(key:key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {

  final formKey = GlobalKey<FormState>();
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
    appBar: AppBar(title: Text("SignUp Page"),),
    body:SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Form(
          key: formKey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 130,),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: TextFormField(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=>
                  email!=null && !EmailValidator.validate(email)
                      ?'Enter a valid Email'
                      :null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: TextFormField(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password)=>
                    password!=null && password.length < 8
                          ?'Password Length should atleast be 8 characters'
                          :null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50.0)
                  ),
                  icon: Icon(Icons.arrow_back,size: 32.0),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  onPressed: signUp,
                ),
              ),
              SizedBox(height: 24,),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black,fontSize: 20),
                    text: 'Already Have an Account ?   ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            decoration: TextDecoration.underline
                        ),
                        text: 'Sign In',
                      )
                    ]
                ),

              )
            ],
          ),
        ),
      ),
    ),
  );

  Future signUp() async {
    final isValid =  formKey.currentState!.validate();
    if(!isValid) return;


    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
      );

    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackbar(e.message);
    }


  }
}
