import 'package:flutter/material.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';

class LeftLineWidget extends StatelessWidget {
  const LeftLineWidget({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Container(
        width:10,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange[600],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        )

    );
  }
}
