import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({Key? key}) : super(key: key);

  @override
  State<AddTasks> createState() => _AddTasksState();
}


class _AddTasksState extends State<AddTasks> {
  final TextEditingController descController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color.fromRGBO(29,28,33,1),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 20,
                    child: Text(
                      "Task Header",
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
                  controller: headerController,
                  validator: (text) {
                    if(text==null || text.length<4){
                      return "atleast 4 characters of input is required";
                    }else{
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(205,217,229,1),
                    hintText: 'e.g first task',
                    hintStyle: TextStyle(color: Colors.black),
                    border:OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 20,
                    child: Text(
                      "Task Desc",
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
                  controller: descController,
                  validator: (text) {
                    if(text==null || text.length<4){
                      return "atleast 4 characters of input is required";
                    }else{
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(205,217,229,1),
                    hintText: 'e.g have to submit my assignment by 15 jan',
                    hintStyle: TextStyle(color: Colors.black),
                    border:OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 20,
                    child: Text(
                      "Task Category",
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
                  controller: categoryController,
                  validator: (text) {
                    if(text==null || text.length<4){
                      return "atleast 4 characters of input is required";
                    }else{
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(205,217,229,1),
                    hintText: 'e.g Study',
                    hintStyle: TextStyle(color: Colors.black),
                    border:OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
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
                  child: Text("ADD TASK",style: TextStyle(fontSize: 20),),
                  onPressed: addTask,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Future addTask () async {
    bool isValid = formKey.currentState!.validate();
    if(!isValid){
      print("invalid");
      return ;
    }
    String collectionPath = DateFormat.EEEE().format(date).toString();
    try{
      final uid = await FirebaseAuth.instance.currentUser!.uid;
      final db = await FirebaseFirestore.instance.collection(collectionPath);
      final doc = await db.doc(uid).get();
      if(doc.exists){
        print(doc.data());
        return;
      }
      final json = {
        "Task" : {
          "1" : {
            "category" : categoryController.text.trim(),
            "completed" : false,
            "desc" : descController.text.trim(),
            "header":headerController.text.trim(),
          }
        },
        "completedTasks":0,
        "date" : DateTime.now(),
        "totalTasks":1,
      };
      db.doc(uid).set(json);
    }catch (error){
      print(error);
    }
  }
}
