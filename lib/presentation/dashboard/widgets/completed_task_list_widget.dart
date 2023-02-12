import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/constants/routes.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/presentation/dashboard/widgets/completed_task_card_widget.dart';
import 'package:kanban_board/presentation/dashboard/widgets/todo_task_card_widget.dart';
import 'package:kanban_board/widgets/empty_card_widget.dart';

class CompletedTaskListWidget extends StatelessWidget {
  CompletedTaskListWidget(
      {Key? key, required this.controller, required this.tasks})
      : super(key: key);

  final TaskBloc controller;
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Completed Tasks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const Spacer(),
              TextButton(
                  onPressed: () => Navigator.pushNamed(
                      context, Routes.historyRoute,
                      arguments: tasks),
                  child: Text('Show All'))
            ],
          ),
          Expanded(
            child: tasks.length > 0
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return CompletedTaskCard(
                          controller: controller, task: task);
                    })
                : EmptyCotainer(
                context: context,
                child: Text('No Completed Tasks'),
          ),)
        ],
      ),
    );
  }
}
