
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  final messageController = TextEditingController();
  var pageHeader = "Programming";


  @override
  Widget build(BuildContext context) =>Scaffold(
      backgroundColor:Colors.black,
      body: Container(
        child: Row(
          children: [
            sidebar(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width-80,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(top:50,left: 20),
                        child: Text( pageHeader ,style: TextStyle(color: Colors.grey,fontSize: 30),),
                      )
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 650,
                      width: MediaQuery.of(context).size.width-80,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width-80,
                      color: Colors.black,
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white
                              ),
                            ),
                            suffixIcon: Icon(Icons.send_outlined,color: Colors.white,),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
  );

  Widget sidebar(){
    return Container(
      color: Colors.black,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                setState(() {
                  pageHeader = "Programming";
                });
              },
              child: Icon(Icons.code,color: Colors.grey,size: 35,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                setState(() {
                  pageHeader = "Sports";
                });
              },
              child: Icon(Icons.sports_soccer_outlined,color: Colors.grey,size: 35,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                setState(() {
                  pageHeader = "Photography";
                });
              },
              child: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 35,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                setState(() {
                  pageHeader = "Music";
                });
              },
              child: Icon(Icons.radio,color: Colors.grey,size: 35,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                setState(() {
                  pageHeader = "Arts";
                });
              },
              child: Icon(Icons.palette_outlined,color: Colors.grey,size: 35,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout_outlined,color: Colors.grey,size: 35,),
            ),
          ),
        ],
      ),
    );
  }
}

