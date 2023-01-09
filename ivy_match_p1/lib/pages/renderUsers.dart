import 'package:flutter/material.dart';
import 'package:ivy_match_p1/Services/ApiServices.dart';
class RenderUsers extends StatefulWidget {
  const RenderUsers({Key? key}) : super(key: key);

  @override
  State<RenderUsers> createState() => _RenderUsersState();
}

class _RenderUsersState extends State<RenderUsers> {
   Future<List<dynamic>> users = ApiServices().getUserData();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Padding(
        padding: const EdgeInsets.only(
            top: 100),
        child: Container(
          height: 600,
          width: 300,
          child: FutureBuilder(
            future : users,
            builder: (context,snapshot){
              if(snapshot.hasData){
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doc = users[index];
                    var data = doc.data().toString();
                    return Padding(
                      padding: const EdgeInsets.only(left:40,bottom: 20),
                      child: Text(data.substring(1,data.length-1).split(',').join('\n'),style: TextStyle(fontSize: 20),),
                    );
                  },
                );
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      )
    ),
  );
}
