import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/model/taskModel.dart';
import 'package:weekly_report/pages/addTasks.dart';
import 'package:weekly_report/services/apiServices.dart';
import 'package:weekly_report/utils/colors.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<String> days = ['sunday','monday','tuesday','wednesday','thursday','friday','saturday'];
  DateTime _selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  Future<Welcome> ? tasks ;

  @override
  void initState(){
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color.fromRGBO(29,28,33,1),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/tasks.png'
                          ),
                          fit:BoxFit.cover,
                        )
                    ),
                  ),
                  Text('TASKS',style: TextStyle(fontSize: 40),)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DatePicker(
                  DateTime(now.year,now.month,now.day-6),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color.fromRGBO(76,56,187, 1),
                  selectedTextColor: Colors.white,
                  daysCount: 7 ,

                  dateTextStyle: TextStyle(
                    color: Colors.grey
                  ),
                  dayTextStyle: TextStyle(
                      color: Colors.grey
                  ),
                  monthTextStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  onDateChange: (date) {
                    // New date selected
                    print(date);
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ],
            ),

            Container(
              height: 300,
              color:Colors.red,
              child: FutureBuilder<Welcome>(
                future: tasks,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    final tasks = snapshot.data!;
                    return buildTask(tasks);
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),

            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTasks()));
                },
                child: Text('CREATE TASK'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: colors.btn,
                ),
            )
          ],
        ),
      ),
    ),
  );

  void getTasks () async {
    String collectionPath = DateFormat.EEEE().format(now).toString();
    String docId = await FirebaseAuth.instance.currentUser!.uid;
    Future<Welcome> _tasks = ApiServices().getTask(collectionPath, docId);
    setState(() {
      tasks = _tasks;
      print(_tasks);
    });
  }

  Widget buildTask(Welcome tasks) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(tasks.tasks.toString()),
      Text(tasks.totalTasks.toString()),
      Text(tasks.completedTasks.toString()),
    ],
  );
}
