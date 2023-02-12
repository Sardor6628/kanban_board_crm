import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/presentation/dashboard/widgets/todo_task_card_widget.dart';
import 'package:kanban_board/widgets/add_update_widget.dart';
import 'package:kanban_board/widgets/empty_card_widget.dart';

class TodoTaskListWidget extends StatelessWidget {
  TodoTaskListWidget({Key? key, required this.controller, required this.tasks})
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
          const Text("Todo Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Expanded(
            child: tasks.length > 0
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return ToDoTaskCard(controller: controller, task: task);
                    })
                : EmptyCotainer(
                    context: context,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AddAndUpdateTaskDialog(
                                context: context, controller: controller));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Icon(Icons.add_circle_sharp, size: 50, color: Theme.of(context).colorScheme.secondary),
                          SizedBox(height: 10),
                          Text('Add a new task', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
