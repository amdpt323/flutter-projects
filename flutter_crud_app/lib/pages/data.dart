import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  late String studentName;
  late String studentID;
  late String studentBranch;
  late double studentCpi;

  getStudentName(name){
    this.studentName=name;
  }
  getStudentID(studentID){
    this.studentID=studentID;
  }

  getStudentBranch(branch){
    this.studentBranch=branch;
  }

  getStudentCPI(cpi){
    this.studentCpi = double.parse(cpi);
  }

  createData(){


    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("studentData").doc(studentName);

    Map<String , dynamic>students={
      "studentName":studentName,
      "studentID":studentID,
      "branch":studentBranch,
      "cpi":studentCpi,
    };

    documentReference.set(students).whenComplete(() =>{
      print("$studentName created")
    } );
  }

  readData(){
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("studentData").doc(studentName);

    documentReference.get().then((dataSnapshot){
      print(dataSnapshot["studentName"]);
      print(dataSnapshot["studentID"]);
      print(dataSnapshot["branch"]);
      print(dataSnapshot["cpi"]);
    });
  }

  updateData(){
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("studentData").doc(studentName);

    Map<String , dynamic>students={
      "studentName":studentName,
      "studentID":studentID,
      "branch":studentBranch,
      "cpi":studentCpi,
    };

    documentReference.set(students).whenComplete(() =>{
      print("$studentName updated")
    } );
  }

  deleteData(){
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("studentData").doc(studentName);

    documentReference.delete().whenComplete(() => {
      print("$studentName deleted")
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userEmail = user.email!.split('@')[0];
    return Scaffold(
      appBar: AppBar(
        title: Text('My flutter CRUD app '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:<Widget>[
            SizedBox(height: 20,),
            Text('$userEmail',
                  style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
                onChanged: (String name){
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Sutdent ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
                onChanged: (String studentID){
                  getStudentID(studentID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Branch",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
                onChanged: (String branch){
                  getStudentBranch(branch);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "CPI",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.blue,
                          width: 2.0,
                        )
                    )
                ),
                onChanged: (String cpi){
                  getStudentCPI(cpi);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                ElevatedButton(
                  style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.green) ,
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )),

                  ) ,
                  child: Text("create",style: TextStyle(color: Colors.white),),

                  onPressed: (){
                    createData();
                  },
                ),
                ElevatedButton(
                  style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.blue) ,
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )),

                  ) ,
                  child: Text("read",style: TextStyle(color: Colors.white),),

                  onPressed: (){
                    readData();

                  },
                ),
                ElevatedButton(
                  style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.orange) ,
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )),

                  ) ,
                  child: Text("update",style: TextStyle(color: Colors.white),),

                  onPressed: (){
                    updateData();
                  },
                ),
                ElevatedButton(
                  style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.red) ,
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    )),

                  ) ,
                  child: Text("delete",style: TextStyle(color: Colors.white),),

                  onPressed: (){
                    deleteData();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50.0)
                ),
                icon: Icon(Icons.arrow_back,size: 32,),
                label: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: ()=>FirebaseAuth.instance.signOut(),
              ),
            ),
            // -+
          ],
        ),
      ),
    );
  }
}