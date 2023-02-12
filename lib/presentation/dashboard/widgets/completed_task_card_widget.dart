import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/widgets/edit_pop_up_button_widget.dart';
import 'package:kanban_board/widgets/left_line_widget.dart';
import 'package:kanban_board/widgets/spend_time_widget.dart';

import '../../../widgets/start_resume_widget.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard({
    Key? key,
    required this.controller,
    required this.task,
  }) : super(key: key);

  final TaskBloc controller;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 300,
            height: 165,
            margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x1f000000),
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 0)
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                LeftLineWidget(task: task),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            task.description,
                            maxLines: 3,
                            style: const TextStyle(
                                color: const Color(0xff909090),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.0),
                          ),
                        ),
                        SizedBox(height: 10),
                        SpentTimeWidget(task: task),
                        Text('Completed on ${ConstantVariables.dateFormat.format(task.completedTime!)}')
                                  ],
                    ),
                  ),
                ),
              ],
            )),
        EditPopUpButton(controller: controller, task: task),
      ],
    );
  }
}
