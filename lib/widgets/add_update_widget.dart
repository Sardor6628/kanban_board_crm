import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/models/tasks.dart';
import '../constants/contant_variables.dart';

Widget AddAndUpdateTaskDialog(
    {required BuildContext context, final controller, Task? task}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;
  if (task != null) {
    titleController.text = task.title;
    descriptionController.text = task.description;
    isUpdate = true;
  }
  return AlertDialog(
    title: Text(isUpdate ? 'Update' : 'Add'),
    content: Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
        child: Column(children: [
          TextField(
            controller: titleController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            textInputAction: TextInputAction.done,
            onEditingComplete: (){
              _addUpdateTask(titleController, descriptionController, isUpdate, controller, task, context);

            },
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
        ]),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel')),
      TextButton(
          onPressed: () {
            _addUpdateTask(titleController, descriptionController, isUpdate, controller, task, context);
          },
          child: Text(isUpdate ? 'Update' : 'Add'))
    ],
  );
}

void _addUpdateTask(TextEditingController titleController, TextEditingController descriptionController, bool isUpdate, controller, Task? task, BuildContext context) {
   if (titleController.text.isNotEmpty &&
      descriptionController.text.isNotEmpty) {
    if (!isUpdate) {
      controller.add(AddTask(
          task: Task(
              id: '${DateTime.now()}',
              title: titleController.text,
              description: descriptionController.text,
              currentStatus: ConstantVariables.todoTask,
              userId: FirebaseAuth.instance.currentUser!.uid,
              createdTime: DateTime.now(),
              startedTime: null,
              spentTime: 0,
              completedTime: null)));
    } else {
      controller.add(UpdateTask(
          task: Task(
              id: task!.id,
              title: titleController.text,
              description: descriptionController.text,
              currentStatus: task.currentStatus,
              userId: task.userId,
              createdTime: task.createdTime,
              startedTime: task.startedTime,
              spentTime: task.spentTime,
              completedTime: task.completedTime)));
    }
    Navigator.pop(context);
  } else {
    Fluttertoast.showToast(msg: 'Please fill all the fields');
  }
}
