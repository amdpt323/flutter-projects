import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ivy_match_p1/Services/ApiServices.dart';

import '../Model/fieldsModel.dart';

class RenderForm extends StatefulWidget {
  const RenderForm({Key? key}) : super(key: key);

  @override
  State<RenderForm> createState() => _RenderFormState();
}

class _RenderFormState extends State<RenderForm> {
  Future<List<Fields>> fieldList = ApiServices().getFormFields();
  List<Map<String,dynamic>> ? _values ;
  String ? _result;
  @override
  void initState(){
    super.initState();
    _values = [];
    _result = "";
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 400,
              width: 400,
              child: FutureBuilder(
                future: fieldList,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final fields = snapshot.data!;
                      return ListView.builder(
                          itemCount: fields.length,
                          itemBuilder: (context,index){
                            final field = fields[index];
                            return BuildField(field);
                          }
                      );
                    }else{
                      return CircularProgressIndicator();
                    }
                  }
              ),
            ),
          ),
        Text(_result!),
        ElevatedButton(
            onPressed: submitForm,
            child: Text('SUBMIT FORM',style: TextStyle(fontSize: 22),),
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
        )
      
      ],
    ),
  );

  Widget BuildField(Fields field){
    if(field.type == 'string'){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              child: Text(
                field.name.toString(),
                style: TextStyle(fontSize: 20,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              onChanged: (value){
                updateValue(field.name.toString(),value);
              },

            ),
          )
        ],
      );
    }
    if(field.type=='date'){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              child: Text(
                field.name.toString(),
                style: TextStyle(fontSize: 20,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Enter Date",
              ),
              onTap: () async {
                DateTime ? pickedDate =  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1969),
                    lastDate: DateTime(2025),
                );
                if(pickedDate!=null){
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  updateValue(field.name.toString(),formattedDate);
                }
              },
            ),
          )
        ],
      );
    }

    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              child: Text(
                field.name.toString(),
                style: TextStyle(fontSize: 20,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              onChanged: (value){
                updateValue(field.name.toString(),value);
              },
            ),
          )
        ],
      );
    }
  }

  updateValue(String key,dynamic value){
    String ? keyFound = null;
    for(var map in _values!){
      if(map.containsKey('id')){
        if(map['id']==key){
          keyFound=key;
        }
      }
    }
  if(keyFound!=null){
    _values?.removeWhere((map) {
      return map['id'] == keyFound;
    });
  }
    Map<String,dynamic> json = { "id":key,"value":value};
    _values?.add(json);
    setState(() {
      _result = _values.toString();
    });
  }

  void submitForm() async {
    Map<String , dynamic>  user = {};
    for(var map in _values!){
      String key = map['id'].toString();
      dynamic value = map['value'];
      user[key] = value;
    }
    try{
      await FirebaseFirestore.instance.collection('users').
      add(user);
    } catch (error){
      throw Exception(
        'Error occured $error'
      );
    }
  }
}
