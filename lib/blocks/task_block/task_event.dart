part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}
class AddTask extends TaskEvent {
  final Task task;
  const AddTask({required this.task});
  @override
  List<Object> get props => [task];
}
class UpdateTask extends TaskEvent {
  final Task task;
  const UpdateTask({required this.task});
  @override
  List<Object> get props => [task];
}
class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}
class TasksLoaded extends TaskEvent {
  final List<Task> tasks;
  const TasksLoaded(this.tasks);
  @override
  List<Object> get props => [tasks];
}
class TasksLoad extends TaskEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
