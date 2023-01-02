import 'package:flutter/material.dart';
import 'package:ivy_match_p1/Services/ApiServices.dart';

import '../Model/User.dart';
import 'addUser.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {

  Future<List<User>> userList = ApiServices().getUsers();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Text(
                "Listed Users",
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 600,
                width:400,
                child: FutureBuilder<List<User>>(
                  future: userList,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final users = snapshot.data!;
                      return ListView.builder(
                          itemCount: users.length,
                        itemBuilder: (context,index){
                            final user = users[index];
                            return UserTile(
                                user.name.toString(),
                                user.profession.toString(),
                                user.jobPosition.toString()
                            );
                        },
                      );
                    }else{
                      return const Text('OOps some error occured');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text("Add User",style: TextStyle(fontSize: 20),),
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
                    MaterialPageRoute(builder: (context)=>AddUser())
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  Widget UserTile(String name,String profession,String jobPosition){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color:Color.fromRGBO(75,84,91, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",style: TextStyle(color: Colors.white,fontSize: 15),),
                  Text(name,style: TextStyle(color: Colors.green,fontSize: 20),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Profession",style: TextStyle(color: Colors.white,fontSize: 15),),
                  Text(profession,style: TextStyle(color: Colors.green,fontSize: 20),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Job-Position",style: TextStyle(color: Colors.white,fontSize: 15),),
                  Text(jobPosition,style: TextStyle(color: Colors.green,fontSize: 20),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
