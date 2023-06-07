import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_online/MyDateUtils.dart';
import 'package:todo_c8_online/database/model/task.dart';
import 'package:todo_c8_online/database/my_database.dart';
import 'package:todo_c8_online/providers/auth_provider.dart';
import 'package:todo_c8_online/ui/components/custom_form_field.dart';
import 'package:todo_c8_online/ui/dialog_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add Task',
            style: Theme.of(context).textTheme.headline4,),
            CustomFormField(label: 'Task title',
                validator: (text){
                  if(text==null || text.trim().isEmpty){
                    return 'please enter task title';
                  }
                },
                controller: titleController),
            CustomFormField(label: 'Task description',
                validator: (text){
                  if(text==null || text.trim().isEmpty){
                    return 'please enter task description';
                  }
                },
                lines: 5,
                controller: descriptionController),
            SizedBox(height: 12,),
            Text('Task Date'),
            InkWell(
              onTap: (){
                showTaskDatePicker();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black54)
                  )
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('${MyDateUtils.formatTaskDate(selectedDate)}',style: TextStyle(
                  fontSize: 18,
                ),),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16)
                ),
                onPressed: (){
                  addTask();
                }, child: Text('Add Task',
            style: TextStyle(fontSize: 18),))
          ],
        ),
      ),
    );
  }

  void addTask()async{
    if(formKey.currentState?.validate()==false){
      return;
    }

    // show loading
    DialogUtils.showLoadingDialog(context, 'Loading...');

    // add task to db
    Task task = Task(
      title: titleController.text,
      desc: descriptionController.text,
      dateTime: MyDateUtils.getDateOnly(selectedDate)
    );
    // 1685916000000
    // 1685923200000
    AuthProvider authProvider = Provider.of<AuthProvider>(context,
        listen: false);
    print('add task time');
    print('${selectedDate.millisecondsSinceEpoch}');
    await MyDataBase.addTask(authProvider.currentUser?.id ?? "", task);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'Task Added Successfully',
    posActionName:'ok' ,
      posAction: (){
      Navigator.pop(context);
      },
    );

    // hide loading and return back to home screen

  }
  var selectedDate = DateTime.now();
  void showTaskDatePicker()async{
    var date = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if(date==null)return;

    selectedDate = date;
    setState(() {

    });
  }
}
