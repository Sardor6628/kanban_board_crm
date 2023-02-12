import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';

class SpentTimeWidget extends StatelessWidget {
  SpentTimeWidget({
    Key? key,
    required this.task,
    this.style,
  }) : super(key: key);
  TextStyle? style;
  final Task task;

  @override
  Widget build(BuildContext context) {
    if (task.spentTime > 1000) {
      final seconds = task.spentTime / 1000;
      final minutes = seconds / 60;
      final hours = minutes / 60;
      int hoursInt = hours.toInt() % 24;
      int minutesInt = minutes.toInt() % 60;
      int secondsInt = seconds.toInt() % 60;
      return Text(
        'Spent: ${ConstantVariables.hourFormat.format(hoursInt)}:${ConstantVariables.hourFormat.format(minutesInt)}:${ConstantVariables.hourFormat.format(secondsInt)}',
        style: style != null
            ? style
            : const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
      );
    }
    return const SizedBox();
  }
}
