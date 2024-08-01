import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/utils/colors.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            color: primaryColors,
            decoration: task.isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Text(
          task.dueDate != null
              ? '${task.dueDate!.toLocal()}'.split(' ')[0]
              : 'No Date',
          style: TextStyle(color: Colors.grey),
        ),
        subtitle: Text(task.details),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            onTaskToggle(task);
          },
        ),
        onLongPress: () => _removeOrDeleteTask(context, task),
      ),
    );
  }
}
