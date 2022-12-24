
import 'package:flutter/material.dart';
final messengerKey = GlobalKey<ScaffoldMessengerState>();
class Utils{

  static showSnackbar(String ? text,bool ? flag){
    if(text == null) return;
    var bgColor = Colors.red;
    if(flag==true){
      bgColor = Colors.green;
    }

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor:bgColor,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}