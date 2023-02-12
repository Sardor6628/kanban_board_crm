import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../models/tasks.dart';

class ExportCSVService {
  static Future<void> convertAndShareCsv({required List<Task> tasks}) async {
    List<List<dynamic>> data = [
      [
        'title',
        'description',
        'created date',
        'created time',
        'completed date',
        'completed time',
        'spent time',
      ]
    ];
    tasks.forEach((element) {
      data.add(element.toList());
    });
    // Create the CSV
    final csv = const ListToCsvConverter().convert(data);
    // Get the directory to store the file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/completedTasks.csv');
    // Write the CSV string to the filea
    await file.writeAsString(csv);
    // Share the file
    Share.shareFiles([file.path], subject: 'Heroes CSV');
  }
}
