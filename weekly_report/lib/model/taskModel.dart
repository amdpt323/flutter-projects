// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Welcome {


   Map<String, Task> tasks;
   int completedTasks;
   int totalTasks;
   String date;

  Welcome({
    required this.tasks,
    required this.completedTasks,
    required this.totalTasks,
    required this.date,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      tasks: Map.from(json["Tasks"]!).map((k, v) => MapEntry<String, Task>(k, Task.fromJson(v))),
      completedTasks: json["completedTasks"],
      totalTasks: json["totalTasks"],
      date: json["date"],
    );
  }

}

class Task {
  final String category;
  final bool completed;
  final String desc;
  final String header;

  Task({
    required this.category,
    required this.completed,
    required this.desc,
    required this.header,
  });



  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      category: json["category"],
      completed: json["completed"],
      desc: json["desc"],
      header: json["header"],
    );
  }
}
