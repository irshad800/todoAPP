import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../model/task.dart';
import '../utils/colors.dart';
import '../widgets/task_tile.dart';
import 'drawer.dart';

class CompletedScreen extends StatelessWidget {
  CompletedScreen({Key? key}) : super(key: key);
  static const id = "completed_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        // Filtering completed tasks
        List<Task> completedTasks =
            state.allTasks.where((task) => task.isDone == true).toList();

        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColors,
            title: const Text(
              'Completed List',
              style: TextStyle(fontFamily: "Airbnb", color: Colors.white60),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: Chip(
                  label: Text(
                    "${completedTasks.length} Completed Tasks",
                    style: TextStyle(
                      fontFamily: "Airbnb",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  backgroundColor: Colors.grey[400],
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return TaskTile(
                      task: task,
                      onTaskToggle: (task) {
                        // Update the task status in the Bloc
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
