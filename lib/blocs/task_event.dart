part of 'task_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

//add
class AddTask extends TasksEvent {
  final Task task;
  const AddTask({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

//update
class UpdateTask extends TasksEvent {
  final Task task;

  const UpdateTask({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

//delete
class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}
