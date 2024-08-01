import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../utils/colors.dart';
import '../widgets/task_lists.dart';
import 'drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = "recycle_bin_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColors,
            title: Row(
              children: [
                const Text(
                  'Recycle Bin',
                  style: TextStyle(fontFamily: "Airbnb", color: Colors.white60),
                ),
                SizedBox(
                  width: 82,
                ),
                TextButton(
                  onPressed: () {},
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
                  "${state.removedTasks.length} Tasks",
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
                taskList: state.removedTasks,
              ),
            ],
          ),
        );
      },
    );
  }
}
