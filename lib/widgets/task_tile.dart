import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../model/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskToggle;
  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  const TaskTile({Key? key, required this.task, required this.onTaskToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            onTaskToggle(task);
          },
        ),
        onLongPress: () => _removeOrDeleteTask(context, task));
  }
}
