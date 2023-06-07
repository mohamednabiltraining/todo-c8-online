import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_c8_online/MyDateUtils.dart';
import 'package:todo_c8_online/database/model/task.dart';
import 'package:todo_c8_online/database/my_database.dart';
import 'package:todo_c8_online/providers/auth_provider.dart';
import 'package:todo_c8_online/ui/home/todos_list/task_item.dart';
import 'package:provider/provider.dart';

class TodosListTab extends StatefulWidget {
  @override
  State<TodosListTab> createState() => _TodosListTabState();
}

class _TodosListTabState extends State<TodosListTab> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Column(
        children: [
          TableCalendar(
          firstDay: DateTime.now().subtract(Duration(days: 365)),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: focusedDay,
            selectedDayPredicate: (date){
            return isSameDay(selectedDay, date);
            },
            onDaySelected: (selectedDay,focusedDay){
            setState(() {
              this.focusedDay =focusedDay;
              this.selectedDay = selectedDay;
            });
            },
            calendarFormat: CalendarFormat.week,
    ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDataBase.getTasksRealTimeUpdate(
                authProvider.currentUser?.id ?? "",
              MyDateUtils.getDateOnly(selectedDay).millisecondsSinceEpoch
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // finished
              var tasksList =
                  snapshot.data?.
                  docs.map((doc) => doc.data()).toList();
              if (tasksList?.isEmpty == true) {
                return Center(
                  child: Text("you don't have any tasks yet"),
                );
              }
              return ListView.builder(
                itemBuilder: (_, index) {
                  return TaskItem(tasksList![index]);
                },
                itemCount: tasksList?.length ?? 0,
              );
            },
          ))
        ],
      ),
    );
  }

  readTasksFromDatabase() async {
    // var authProvider  = Provider.of<AuthProvider>(context,listen: false);
    // var result = await MyDataBase.getTasks(authProvider.currentUser?.id??"");
    // tasksList = result.docs.map((docSnapshot) => docSnapshot.data()).toList();
    // setState(() {
    //
    // });
  }
}
