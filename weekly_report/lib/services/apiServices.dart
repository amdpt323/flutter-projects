import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weekly_report/model/quoteModel.dart';

import '../model/taskModel.dart';


class ApiServices{
  final Dio _dio = Dio();


  Future<QuoteModel> getQuote() async {
    try{
      final respose = await _dio.get('https://api.quotable.io/random');
      QuoteModel quote = QuoteModel.formJson(respose.data);
      return quote;

    }catch(error){
      throw Exception(
        'Error Occured $error'
      );
    }
  }

  Future<Welcome> getTask(String collectionPath , String docId) async{
    try{
      final response = await FirebaseFirestore.instance
          .collection(collectionPath).doc(docId).get() ;
      if(response.exists){
        final data = response.data()!;
        final Welcome  task = Welcome.fromJson(data);
        return task;
      }else{
        throw Exception(
          'No data available'
        );
      }
    }catch(error){
      throw Exception(
          'Error Occured $error'
      );
    }
  }
}