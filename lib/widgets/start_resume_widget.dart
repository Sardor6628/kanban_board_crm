import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';

class StartResumeWidget extends StatelessWidget {
  const StartResumeWidget({
    Key? key,
    required this.controller,
    required this.task,
  }) : super(key: key);

  final TaskBloc controller;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          controller.add(UpdateTask(
              task: task.copyWith(
                  currentStatus: ConstantVariables.currentTask,
                  startedTime: DateTime.now())));
        },
        child: task.spentTime > 1000 ? Text('Resume') : Text('Start'));
  }
}