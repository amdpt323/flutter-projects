import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ivy_match_p1/Utils/utils.dart';
import 'package:ivy_match_p1/pages/viewUsers.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();
  Title ? title = Title.Mr;
  JobPosition ? jobPosition = JobPosition.ProjectManager;
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    professionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                child: SizedBox(
                  child: Text(
                    'User Form',
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Text(
                        "Title",
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                    child: DropdownButton<Title>(
                      value: title,
                      onChanged:(newValue){
                        setState(() {
                          title=newValue;
                        });
                      } ,
                      dropdownColor: Colors.black,
                      elevation: 0,
                      alignment: Alignment.center,
                      items: Title.values.map((Title title){
                        return DropdownMenuItem(
                            value: title,
                            child: Container(
                              child: Text(
                                title.toString().split('.')[1]
                                ,style: TextStyle(color: Colors.green,fontSize: 18),
                              ),
                            )
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const SizedBox(
                  child: Text("Name",style: TextStyle(color:Colors.white,fontSize: 18 ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name){
                    if(name==null || name.length==0){
                      return "Please provide Username";
                    }else if(name!=null && name.length<4){
                      return "Username Should be atleast of 4 characters";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white,fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'e.g Alex from Microsoft',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      )
                    ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const SizedBox(
                  child: Text("Profession",style: TextStyle(color:Colors.white,fontSize: 18 ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: professionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value==null || value.length==0){
                      return "Please provide Username";
                    }else if(value!=null && value.length<4){
                      return "Username Should be atleast of 4 characters";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white,fontSize: 18),
                  decoration: InputDecoration(
                      hintText: 'e.g Student',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          )
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                child: const SizedBox(
                  child: Text("Job Position Applying for",style: TextStyle(color:Colors.white,fontSize: 18 ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
                child: DropdownButton<JobPosition>(
                  value: jobPosition,
                  onChanged:(newValue){
                    setState(() {
                      jobPosition=newValue;
                    });
                  } ,
                  dropdownColor: Colors.black,
                  elevation: 0,
                  alignment: Alignment.center,
                  items: JobPosition.values.map((JobPosition jobPosition){
                    return DropdownMenuItem(
                        value: jobPosition,
                        child: Container(
                          child: Text(
                            jobPosition.toString().split('.')[1]
                            ,style: TextStyle(color: Colors.green,fontSize: 18),
                          ),
                        )
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Submit",style: TextStyle(fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                      )
                  ),
                  onPressed: addUser,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("View Users",style: TextStyle(fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                      )
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ViewUsers())
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void addUser() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    try{
      final name = '${title.toString().split('.')[1]} ${nameController.text.trim()}';
      await FirebaseFirestore.instance.collection('users')
          .add({
        "name":name,
        "profession":professionController.text.trim(),
        "jobPosition":jobPosition.toString().split('.')[1],
      });
      Utils.showSnackBar("User added Succefully", true);
      setState(() {
        nameController.text="";
        professionController.text="";
      });
    }catch(error){
      throw Exception(
        'error occured $error'
      );
    }
  }

}

enum Title{
  Mr,
  Mrs,
}

enum JobPosition{
  FrontendDeveloper,
  BackendDeveloper,
  DatabaseManagement,
  DevOps,
  CloudEngineering,
  ProjectManager,
  Freelancer,
}
