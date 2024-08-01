import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../model/task.dart';
import '../screens/edit_task.dart';
import '../services/notification_service.dart'; // Import NotificationService

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskToggle;
  final Function(Task)? onEditTask;

  const TaskTile({
    Key? key,
    required this.task,
    required this.onTaskToggle,
    this.onEditTask,
  }) : super(key: key);

  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _notifyCompletion(BuildContext context) {
    final notificationService = InheritedNotificationService.of(context);
    notificationService.showNotification('Task Completed',
        'The task "${task.title}" has been marked as completed.');
  }

  Color _getBackgroundColor() {
    if (task.isPinned) {
      return Colors.blue.withOpacity(0.1);
    } else if (task.isDone!) {
      return Colors.green.withOpacity(0.1);
    } else {
      return Colors.grey.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _getBackgroundColor(),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (bool? value) {
            final updatedTask = task.copyWith(isDone: value);
            onTaskToggle(updatedTask);
            if (value == true) {
              _notifyCompletion(context); // Notify when the task is completed
            }
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: Colors.black,
            decoration: task.isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          task.dueDate != null
              ? '${task.dueDate!.toLocal()}'.split(' ')[0]
              : 'No Date',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    oldTask: task,
                  ),
                ),
              );
            } else if (value == 'delete') {
              _removeOrDeleteTask(context, task);
            } else if (value == 'pin') {
              final updatedTask = task.copyWith(isPinned: !task.isPinned);
              context.read<TasksBloc>().add(UpdateTask(task: updatedTask));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'edit',
              child: Text('Edit'),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete'),
            ),
            PopupMenuItem<String>(
              value: 'pin',
              child: Text(task.isPinned ? 'Unpin' : 'Pin'),
            ),
          ],
        ),
        onLongPress: () => _removeOrDeleteTask(context, task),
      ),
    );
  }
}
