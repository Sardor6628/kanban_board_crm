import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/widgets/left_line_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class InProgessTaskWidget extends StatefulWidget {
  const InProgessTaskWidget({
    Key? key,
    required this.controller,
    required this.task,
  }) : super(key: key);

  final TaskBloc controller;
  final Task task;

  @override
  State<InProgessTaskWidget> createState() => _InProgessTaskWidgetState();
}

class _InProgessTaskWidgetState extends State<InProgessTaskWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  late Task task;
  bool isDisposed = false;

  @override
  void initState() {
    task = widget.task;
    if(!isDisposed){
      _stopWatchTimer.setPresetTime(
          mSec: (DateTime.now().millisecondsSinceEpoch -
                  task.startedTime!.millisecondsSinceEpoch) +
              task.spentTime); //set start time
      _stopWatchTimer.onStartTimer(); // starts the timer
    }
    super.initState();
  }
  @override
  void dispose() async {
      isDisposed = true;
    _stopWatchTimer.dispose();
    super.dispose();
  }

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
              boxShadow: [BoxShadow(
                  color: const Color(0x1f000000),
                  offset: Offset(0,4),
                  blurRadius: 11,
                  spreadRadius: 0
              )] ,
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
                        Text(
                          widget.task.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            widget.task.description,
                            maxLines: 2,
                            style: const TextStyle(
                                color: const Color(0xff909090),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.0),
                          ),
                        ),

                        const SizedBox(height: 5),
                        StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: _stopWatchTimer.rawTime.value,
                          builder: (context, snap) {
                           if (!snap.hasError) {
                              final value = snap.data!;
                              final displayTime = StopWatchTimer.getDisplayTime(value,
                                  milliSecond: false);
                              return Column(
                                children: <Widget>[
                                  Text(
                                    displayTime,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox();
                          },

                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  widget.controller.add(UpdateTask(
                                      task: widget.task.copyWith(
                                          currentStatus: ConstantVariables.todoTask,
                                          spentTime: _stopWatchTimer.rawTime.value,)));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffb2b2b2),
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8),
                                    child: Text('Pause', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),))),
                            GestureDetector(
                                onTap: () {
                                  widget.controller.add(UpdateTask(
                                      task: widget.task.copyWith(
                                          currentStatus: ConstantVariables.completedTask,
                                          spentTime: _stopWatchTimer.rawTime.value,
                                          completedTime: DateTime.now())));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8),
                                    child: Text('Complete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),))),


                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),

      ],
    );
  }
}
