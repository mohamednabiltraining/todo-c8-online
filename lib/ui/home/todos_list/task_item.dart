import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_online/database/model/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c8_online/database/my_database.dart';
import 'package:todo_c8_online/providers/auth_provider.dart';
import 'package:todo_c8_online/ui/dialog_utils.dart';
class TaskItem extends StatefulWidget {

  Task task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
                onPressed:(buildContext){
                  deleteTask();
                },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft:  Radius.circular(18),
              ),

            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).primaryColor),
                width: 8,
                height: 80,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.task.title}',
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 18,),
                  Text('${widget.task.desc}')
                ],
              )),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Image.asset('assets/images/ic_check.png'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(){
    DialogUtils.showMessage(context, 'Do you want to delete this task?',
    posActionName: 'Yes',
      posAction: (){
      deleteTaskFromDataBase();
      },
      negActionName: 'Cancel'
    );
  }
  void deleteTaskFromDataBase()async{
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    try{
      await MyDataBase.deleteTask(authProvider.currentUser?.id??"",
          widget.task.id??"");
      Fluttertoast.showToast(
          msg: "Task deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }catch(e){
      DialogUtils.showMessage(context, 'something went wrong,'
          '${e.toString()}',);
    }
  }
}
