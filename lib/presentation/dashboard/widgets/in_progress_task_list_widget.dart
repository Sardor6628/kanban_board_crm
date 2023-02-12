import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/presentation/dashboard/widgets/in_progress_card_widget.dart';
import 'package:kanban_board/presentation/dashboard/widgets/todo_task_card_widget.dart';
import 'package:kanban_board/widgets/empty_card_widget.dart';

class InProgressListWidget extends StatelessWidget {
  InProgressListWidget(
      {Key? key, required this.controller, required this.tasks})
      : super(key: key);

  final TaskBloc controller;
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("In Progress Tasks",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Expanded(
            child: tasks.length>0?ListView.builder(
                itemCount: tasks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Task task = tasks[index];
                  return new InProgessTaskWidget(
                      controller: controller, task: task, key: Key(task.id));
                }):EmptyCotainer(
              context: context,
              child: Text('No In Progress Tasks'),
            ),
          ),
        ],
      ),
    );
  }
}
