import 'package:flutter/material.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/services/export_csv.dart';
import 'package:kanban_board/widgets/left_line_widget.dart';
import 'package:kanban_board/widgets/spend_time_widget.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = ModalRoute.of(context)!.settings.arguments as List<Task>;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Tasks'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              const _textStyle = const TextStyle(
                color:  Color(0xff909090));
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x1f000000),
                          offset: Offset(0, 4),
                          blurRadius: 11,
                          spreadRadius: 0)
                    ],
                    color: Colors.white),
                margin: const EdgeInsets.only(bottom: 10),
                height: 160,
                child: Row(
                  children: [
                    LeftLineWidget(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(
                            task.description,
                            maxLines: 4,
                            style: const TextStyle(
                                color: const Color(0xff909090),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.0),
                          ),
                          const SizedBox(height: 5),
                          Text(
                              'Completed at: ${ConstantVariables.dateFormat.format(task.completedTime ?? DateTime.now())}',
                              style: _textStyle),
                          const SizedBox(height: 5),
                          SpentTimeWidget(
                            task: task,
                            style: _textStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          // color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  ExportCSVService.convertAndShareCsv(tasks: tasks);
                },
                child: Container(
                  // width: 100,
                  margin:  EdgeInsets.only(bottom: 25),
                  height: 40,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Icon(Icons.download_for_offline_outlined,
                          color: Colors.white),
                      SizedBox(width: 5),
                      Text('Export',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
