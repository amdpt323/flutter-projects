
import 'package:email_validator/email_validator.dart';
import 'package:fetch_movie_app/widgets/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Theme.of(context).backgroundColor,
    appBar: AppBar(title: Text('Forgot Password'),),
    body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:220,bottom: 50),
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                style: TextStyle(color: Colors.black,fontSize: 20),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(205,217,229,1),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                validator: (email) =>
                    email!=null && !EmailValidator.validate(email)
                        ? 'Enter A Valid Email'
                        :null,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                  )
                ),
                child: Text(
                    "Send Email",
                    style: TextStyle(fontSize: 20),
                ),
                onPressed: resetPassword,
              ),
            )
          ],
        ),
      ),
    )
  );

  Future resetPassword () async{

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
      );
      Utils.showSnackbar('Password Email Sent Successfully', true);
    } on FirebaseAuthException catch(e) {
      Utils.showSnackbar(e.message, false);
    }
  }
}
