import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../model/task.dart';
import '../utils/colors.dart';
import '../widgets/task_lists.dart';
import 'drawer.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  static const id = "task_screen";
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksLists = state.allTasks;
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColors,
            title: const Text(
              'favourite List',
              style: TextStyle(fontFamily: "Airbnb", color: Colors.white60),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 5),
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
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TaskLists(
                taskList: tasksLists,
              ),
            ],
          ),
        );
      },
    );
  }
}
