import 'package:flutter/material.dart';
import 'package:todoapp/screens/drawer.dart';
import 'package:todoapp/utils/colors.dart';

import '../bloc/bloc_exports.dart';
import '../model/task.dart';
import '../widgets/task_lists.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);
  static const id = "task_screen";
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
                  style: TextStyle(fontFamily: "Airbnb", color: Colors.white60),
                ),
                SizedBox(
                  width: 112,
                ),
                TextButton(
                  onPressed: () => _addTask(context),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          drawer: MyDrawer(),
          body: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
                  child: Chip(
                label: Text(
                  "${state.allTasks.length} Tasks",
                  style: TextStyle(
                    fontFamily: "Airbnb",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.grey[400],
                labelStyle: TextStyle(color: Colors.black),
              )),
              SizedBox(
                height: 10,
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
