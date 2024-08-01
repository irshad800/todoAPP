import 'package:flutter/material.dart';
import 'package:todoapp/widgets/task_tile.dart';

import '../model/task.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var task = taskList[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}
