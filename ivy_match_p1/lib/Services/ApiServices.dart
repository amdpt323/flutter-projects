import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ivy_match_p1/Model/User.dart';
import 'package:ivy_match_p1/Model/fieldsModel.dart';

class ApiServices {
  final _db = FirebaseFirestore.instance;

  Future<List<User>> getUsers () async {
    try{
      final response = await _db.collection("users").get();
      var users = response.docs as List;
      List<User> userList = users.map((m)=>User.fromJson(m)).toList();
      return userList;
    }catch (error){
      throw Exception(
        'Error occured $error'
      );
    }
  }

  Future<List<Fields>> getFormFields () async {
    try{
      final response = await _db.collection("form_fields").get();
      var fields = response.docs as List;
      List<Fields> fieldList = fields.map((m) => Fields.fromJson(m)).toList();
      return fieldList;
    }catch (error){
      throw Exception(
          'Error occured $error'
      );
    }
  }

  Future<List<dynamic>> getUserData() async{
    try{
      final response = await _db.collection('users').get();
      var users = response.docs as List;
      List<String> data = users.map((e) =>e.toString() ).toList();
      print(data);
      return users;
    }catch (error){
      throw Exception(
          'Error occured $error'
      );
    }
  }
}