import 'package:flutter/material.dart';
import 'package:todoapp/screens/recycle_bin.dart';
import 'package:todoapp/screens/task_screen.dart';

import '../bloc/bloc_exports.dart';
import '../utils/colors.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColors,
              ),
              child: Text(
                'Tasks',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(TaskScreen.id),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_special,
                    color: primaryColors,
                  ),
                  title: Text('My Tasks'),
                  trailing: Text("${state.allTasks.length}"),
                ),
              );
            },
          ),
          Divider(),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: primaryColors,
                  ),
                  title: Text('Bin'),
                  trailing: Text("${state.removedTasks.length}"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
