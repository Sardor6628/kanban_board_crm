import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/widgets/add_update_widget.dart';

class EditPopUpButton extends StatelessWidget {
  const EditPopUpButton({
    Key? key,
    required this.controller,
    required this.task,
  }) : super(key: key);

  final TaskBloc controller;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        top: 4,
        child: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (String choice) {
            if (choice == 'Edit') {
              showDialog(
                  context: context,
                  builder: (context) => AddAndUpdateTaskDialog(
                      context: context, controller: controller, task: task));
            } else if (choice == 'Delete') {
              controller.add(DeleteTask(task: task));
            }
            else if (choice == 'Reset') {
              controller.add(UpdateTask(task: task.copyWith(spentTime: 0)));
            }
          },
          itemBuilder: (BuildContext context) {
            return ['Edit', 'Delete', 'Reset'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ));
  }
}
