import 'package:flutter/material.dart';
import 'package:kanban_board/widgets/add_update_widget.dart';

import '../blocks/task_block/task_bloc.dart';
Widget EmptyCotainer({required BuildContext context, required Widget child}){

  return Stack(
    children: [
      Opacity(
        opacity : 0.3400000035762787,
        child:   Container(
                    decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(7)
                ),
                border: Border.all(
                    color: const Color(0xff939191),
                    width: 1.5
                ),
                color: const Color(0xffebeaea)
            ),
        ),
      ),
      Center(child: child)
    ],
  );
}