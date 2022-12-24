import 'package:fetch_movie_app/widgets/FogotPassPage.dart';
import 'package:fetch_movie_app/widgets/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef voidCallback = void Function();

class LoginPage extends StatefulWidget {
  final voidCallback onClickedSignUp;
  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    extendBodyBehindAppBar: true,
    appBar: AppBar(title: Text('Login'),),
    body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:120,bottom: 50),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 150,
                    height: 200,
                    color: Theme.of(context).colorScheme.primary,

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 20,
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(205,217,229,1),
                  label: Text("Enter Your Email",
                    style: TextStyle(color:Theme.of(context).colorScheme.secondary),
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 20,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(205,217,229,1),
                    label: Text("Enter Your Password",
                      style: TextStyle(color:Theme.of(context).colorScheme.secondary),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    )
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: isChecked,
                      onChanged: (value){
                        isChecked=!isChecked;
                        setState(() {
                        });
                      },
                    ),
                    Text("Remember You")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                    onTap: ()=>Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>ForgotPassword())
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:24.0,left: 8.0,right: 8.0,bottom: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400,50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text("Login",style: TextStyle(fontSize: 20),),
                onPressed: logIn,
              ),
            ),

            Padding(
              padding:EdgeInsets.all(8),
              child: Container(
                alignment: Alignment.topRight,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      text: "Don't Have An Account ? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          style: TextStyle(
                            color:Colors.white,
                          ),
                          text: 'Sign Up',
                        )
                      ]
                  ),

                ),
              ),
            )

          ],

        ),

      ),
    ),
  );

  Future logIn ()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim()
      );
    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackbar(e.message,false);
    }
  }
}
