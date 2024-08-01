part of 'task_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> removedTasks;

  const TasksState({
    this.allTasks = const [],
    this.removedTasks = const [],
  });

  TasksState copyWith({
    List<Task>? allTasks,
    List<Task>? removedTasks,
  }) {
    return TasksState(
      allTasks: allTasks ?? this.allTasks,
      removedTasks: removedTasks ?? this.removedTasks,
    );
  }

  @override
  List<Object> get props => [allTasks, removedTasks];

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      allTasks: (map['allTasks'] as List<dynamic>)
          .map((item) => Task.fromMap(item as Map<String, dynamic>))
          .toList(),
      removedTasks: (map['removedTasks'] as List<dynamic>)
          .map((item) => Task.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((task) => task.toMap()).toList(),
      'removedTasks': removedTasks.map((task) => task.toMap()).toList(),
    };
  }
}
