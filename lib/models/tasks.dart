import 'package:kanban_board/constants/contant_variables.dart';

class Task {
  final String id;
  final String title;
  final String userId;
  final String description;
  final DateTime? createdTime;
  final DateTime? completedTime;
  final DateTime? startedTime;
  final int spentTime;
  final String currentStatus;

  Task({
    required this.id,
    required this.title,
    required this.userId,
    required this.description,
    required this.createdTime,
    required this.completedTime,
    required this.startedTime,
    required this.spentTime,
    required this.currentStatus,
  });

  factory Task.fromFirestore(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      title: data['title'],
      userId: data['userId'],
      description: data['description'],
      createdTime: data['createdTime'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(data['createdTime'])
          : null,
      completedTime: data['completedTime'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(data['completedTime'])
          : null,
      startedTime: data['startedTime'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(data['startedTime'])
          : DateTime.now(),
      spentTime: data['spentTime'] != null ? data['spentTime'] : 0,
      currentStatus: data['currentStatus'],
    );
  }

//clone of task with modification
  Task copyWith({
    String? id,
    String? title,
    String? userId,
    String? description,
    DateTime? createdTime,
    DateTime? completedTime,
    DateTime? startedTime,
    int? spentTime,
    String? currentStatus,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
      completedTime: completedTime ?? this.completedTime,
      startedTime: startedTime ?? this.startedTime,
      spentTime: spentTime ?? this.spentTime,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
//convert task to map
  String toString() {
    return 'Task(id: $id, title: $title, userId: $userId, description: $description, createdTime: $createdTime, completedTime: $completedTime, startedTime: $startedTime, spentTime: $spentTime, currentStatus: $currentStatus)';
  }
  //convert task to list(needed for csv export)
  List<dynamic> toList() {
    final seconds = spentTime/ 1000;
    final minutes = seconds / 60;
    final hours = minutes / 60;
    int hoursInt = hours.toInt() % 24;
    int minutesInt = minutes.toInt() % 60;
    int secondsInt = seconds.toInt() % 60;
    return [
      title,
      description,
      ConstantVariables.dateOnlyFormat.format(createdTime!),
      ConstantVariables.timeFormat.format(createdTime!),
      ConstantVariables.dateOnlyFormat.format(completedTime!),
      ConstantVariables.timeFormat.format(completedTime!),
      ConstantVariables.hourFormat.format(hoursInt) +
          ":" +
          ConstantVariables.hourFormat.format(minutesInt) +
          ":" +
          ConstantVariables.hourFormat.format(secondsInt)
    ];
  }
}
