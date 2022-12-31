
import 'package:chatrooms/widgets/Utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  @override
  void dispose(){
    usernameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height:150,
                    width: 150,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey,
                    hintText: "e.g.  Alex from Microsoft",
                  ),
                  cursorColor: Colors.black,
                  autovalidateMode:AutovalidateMode.always,
                  validator: (value){
                    if(value==null || value.length == 0){
                      return "Please enter a username";
                    }
                    if(value!=null && value.length < 4){
                      return "Please enter a username that is 4 characters long";
                    }
                    return null;
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 32),
              child: ElevatedButton(
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                onPressed: signinAnonymously,
              ),
            )
          ],
        ),
      ),
    ) ,
  );
  Future signinAnonymously () async {
    final isValid = formKey.currentState!.validate();
    if(isValid) {
      try {
        dynamic result = await FirebaseAuth.instance.signInAnonymously();
        debugPrint(result.user);
        Utils.showSnackbar("Logged in succesfully", true);
      } on FirebaseAuthException catch (e) {
        Utils.showSnackbar(e.message, false);
      }
    }else{
      return;
    }
  }
}
