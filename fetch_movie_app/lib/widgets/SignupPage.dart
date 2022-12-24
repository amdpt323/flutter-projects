
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef voidCallback = void Function();

class SignupPage extends StatefulWidget {

  final voidCallback onClickedSignIn;
  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    extendBodyBehindAppBar: true,
    appBar: AppBar(title: Text('SignUp'),),
    body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:150,bottom: 50),
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
              ),
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
                child: Text("SignUp",style: TextStyle(fontSize: 20),),
                onPressed: (){},
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
                      text: "Already Have An Account ? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          style: TextStyle(
                            color:Colors.white,
                          ),
                          text: 'Sign In',
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

}
