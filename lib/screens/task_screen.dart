import 'package:flutter/material.dart';
import 'package:todoapp/utils/colors.dart';

import '../bloc/bloc_exports.dart';
import '../model/task.dart';
import '../widgets/task_lists.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: primaryColors,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AddTaskScreen(titleController: titleController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksLists = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColors,
            title: Row(
              children: [
                const Text(
                  'Task List',
                  style: TextStyle(fontFamily: "Airbnb", color: Colors.black),
                ),
                SizedBox(
                  width: 166,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Text(
                  "Tasks",
                  style: TextStyle(
                      fontFamily: "Airbnb",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              TaskLists(
                taskList: tasksLists,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColors,
            onPressed: () => _addTask(context),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
