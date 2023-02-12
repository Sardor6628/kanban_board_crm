import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/repositories/task_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskRepository _taskRepository;
  Stream<List<Task>> _taskSubscription = const Stream.empty();

  TaskBloc(this._taskRepository) : super(TaskInitial()) {
    on<TasksLoad>((event, emit) {
      _taskSubscription = Stream.empty();
      try {
        log('reshreshing the stream');
        log('user id--${FirebaseAuth.instance.currentUser!.email}');
        _taskSubscription = _taskRepository.getUserTasks(FirebaseAuth.instance.currentUser!.uid);
        if (_taskSubscription != const Stream.empty()) {
          emit(TaskLoadSuccess(_taskSubscription));
        }
      } catch (e) {
        log("message--$e");
        emit(TaskLoadFailure(e.toString()));
      }
    });
    on<DeleteTask>((event, emit) {
      try {
        _taskRepository.deleteTask(task: event.task);
        emit(TaskLoadSuccess(_taskSubscription));
      } catch (e) {
        emit(TaskLoadFailure(e.toString()));
      }
    });
    on<AddTask>((event, emit) {
      try {
        _taskRepository.addTask(task: event.task);
        emit(TaskLoadSuccess(_taskSubscription));
      } catch (e) {
        emit(TaskLoadFailure(e.toString()));
      }
    });
    on<UpdateTask>((event, emit) {
      try {
        _taskRepository.updateTask(task: event.task);
        emit(TaskLoadSuccess(_taskSubscription));
      } catch (e) {
        emit(TaskLoadFailure(e.toString()));
      }
    });
  }
}
