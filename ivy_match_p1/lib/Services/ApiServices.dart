import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ivy_match_p1/Model/User.dart';

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
}