part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}
class TaskLoadInProgress extends TaskState {
  @override
  List<Object> get props => [];
}
class TaskLoadSuccess extends TaskState {
  Stream<List<Task>> taskSubscription;
  TaskLoadSuccess(this.taskSubscription);
  @override
  List<Object> get props => [taskSubscription];
}
class TaskLoadFailure extends TaskState {
  final String message;
  const TaskLoadFailure(this.message);
  @override
  List<Object> get props => [message];
}

