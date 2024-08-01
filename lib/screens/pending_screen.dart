import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../model/task.dart';
import '../utils/colors.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'drawer.dart';

class PendingScreen extends StatelessWidget {
  PendingScreen({Key? key}) : super(key: key);
  static const id = "task_screen";
  final TextEditingController titleController = TextEditingController();
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: primaryColors,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AddTaskScreen(
          titleController: titleController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> pendingTasks =
            state.allTasks.where((task) => !task.isDone!).toList();

        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColors,
            title: const Text(
              'Task List',
              style: TextStyle(fontFamily: "Airbnb", color: Colors.white60),
            ),
            actions: [
              TextButton(
                onPressed: () => _addTask(context),
                child: const Icon(
                  Icons.add,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: Chip(
                  label: Text(
                    "${pendingTasks.length} Pending Tasks",
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
                  itemCount: pendingTasks.length,
                  itemBuilder: (context, index) {
                    final task = pendingTasks[index];
                    return TaskTile(
                      task: task,
                      onTaskToggle: (task) {
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
