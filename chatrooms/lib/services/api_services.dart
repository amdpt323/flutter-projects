import 'package:chatrooms/Model/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  final _db = FirebaseFirestore.instance;

  Future<List<Message>> getMessages(String text) async{
    try{
      final response = await _db.collection(text).orderBy('createdAt',descending: true).get();
      var messages = response.docs as List;
      List<Message> messsageList  = messages.map((m)=>Message.fromJson(m)).toList();
      return messsageList;
    }catch(error){
      throw Exception(
        'Exception occoured $error'
      );
    }
  }
}