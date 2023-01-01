
import 'package:chatrooms/services/api_services.dart';
import 'package:chatrooms/widgets/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/messageModel.dart';

class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var pageHeader = "programming";


  Future<List<Message>> displayMessages = ApiService().getMessages("programming");


  @override
  Widget build(BuildContext context) =>Scaffold(
      backgroundColor:Colors.black,
      body: Form(
        key: formKey,
        child: Container(
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
                          child: Text(
                            "${pageHeader[0].toUpperCase()}${pageHeader.substring(1).toLowerCase()}"
                            ,style: TextStyle(color: Colors.grey,fontSize: 30),
                          ),
                        )
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 650,
                        width: MediaQuery.of(context).size.width-80,
                        color: Theme.of(context).backgroundColor,
                        child: FutureBuilder<List<Message>>(
                          future:displayMessages,
                          builder: (context,snapshot){
                            if(snapshot.hasData){
                              final messages = snapshot.data!;
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: messages.length,
                                itemBuilder: (context,index){
                                  final message = messages[index];
                                  dynamic result = FirebaseAuth.instance.currentUser;

                                  if(result.uid==message.uid) {
                                    return OwnMessageBlock(
                                        message.uid.toString(),
                                        message.message.toString());
                                  }else{
                                    return OtherMessageBlock(
                                        message.uid.toString(),
                                        message.message.toString()
                                    );
                                  }
                                }
                              );
                            }
                            else{
                              return const Text('No messages yet');
                            }
                          },
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width-80,
                        color: Colors.black,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (message){
                            if(message==null || message?.length == 0){
                              return "Message field cant be empty";
                            }else{
                              return null;
                            }
                          },
                          controller: messageController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap:sendMessage,
                                  child:Icon(Icons.send_outlined,color: Colors.white,)
                              ),
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
        ),
      )
  );

  void sendMessage() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    dynamic result = FirebaseAuth.instance.currentUser;
    try{
      await FirebaseFirestore.instance.collection(pageHeader).add({
        "message":messageController.text.trim(),
        "uid" : result.uid,
        "createdAt":FieldValue.serverTimestamp(),
      }).then((value) => messageController.text = "").catchError((onError)=>Utils.showSnackbar(onError, false));
      setState(() {
        displayMessages=ApiService().getMessages(pageHeader);
      });
    }catch (error){
      Utils.showSnackbar('Something went wrong', false);
    }
  }

  Widget OtherMessageBlock(String uid,String message){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)
          ),
          child: Container(
            height: 75,
            color: Color.fromRGBO(75,84,91,1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height:18,
                    width: 200,
                    color: Color.fromRGBO(103,110,116,1),
                    child: Text(uid,style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 40,
                    width: 200,
                    color: Color.fromRGBO(103,110,116,1),
                    child: Text(message,style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget OwnMessageBlock(String uid,String message){
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
              bottomLeft: Radius.circular(18)
          ),
          child: Container(
            height: 75,
            color: Color.fromRGBO(185,185,185,1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: Container(
                    height:18,
                    width: 120,
                    color: Color.fromRGBO(208,208,208,1),
                    child: Text(uid,style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: Container(
                    height: 40,
                    width: 200,
                    color: Color.fromRGBO(208,208,208,1),
                    child: Text(message,style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sidebar(){
    return SingleChildScrollView(
      child: Container(
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
                    pageHeader = "programming";
                    displayMessages=ApiService().getMessages(pageHeader);
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
                    pageHeader = "sports";
                    displayMessages=ApiService().getMessages(pageHeader);
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
                    pageHeader = "photography";
                    displayMessages=ApiService().getMessages(pageHeader);
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
                    pageHeader = "music";
                    displayMessages=ApiService().getMessages(pageHeader);
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
                    pageHeader = "arts";
                    displayMessages=ApiService().getMessages(pageHeader);
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
      ),
    );
  }
}

