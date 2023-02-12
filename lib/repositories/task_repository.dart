import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_board/models/tasks.dart';

class TaskRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  //add task
  Future<void> addTask({required Task task}) async {
    return await tasks.add({
      'id': task.id,
      'title': task.title,
      'userId': task.userId,
      'description': task.description,
      'createdTime': DateTime.now().microsecondsSinceEpoch,
      'completedTime': null,
      'startedTime': task.startedTime?.microsecondsSinceEpoch,
      'spentTime': task.spentTime,
      'currentStatus': task.currentStatus,
    }).then((value) => Fluttertoast.showToast(msg: "Task Added").catchError(
        (error) => Fluttertoast.showToast(msg: "Failed to add user: $error")));
  }
  //update task
  Future<void> updateTask({required Task task}) async {
    return tasks.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'completedTime': task.completedTime?.microsecondsSinceEpoch,
      'startedTime': task.startedTime?.microsecondsSinceEpoch,
      'spentTime': task.spentTime,
      'currentStatus': task.currentStatus,
    }).then((value) => Fluttertoast.showToast(msg: "Task Updated").catchError(
        (error) =>
            Fluttertoast.showToast(msg: "Failed to update task: $error")));
  }
  //delete task
  Future<void> deleteTask({required Task task}) async {
    return await tasks.doc(task.id).delete().then((value) =>
        Fluttertoast.showToast(msg: "Task Deleted").catchError((error) =>
            Fluttertoast.showToast(msg: "Failed to delete task: $error")));
  }
  //get all tasks
  Stream<List<Task>> getUserTasks(String userId) {
    log('getUserTasks');
    Stream<QuerySnapshot> snapshots = tasks
        .where('userId', isEqualTo: userId)
        .orderBy('createdTime', descending: true)
        .snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
