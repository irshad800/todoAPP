import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../model/task.dart';
import '../services/gen_id.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                "Add Task",
                style: TextStyle(fontFamily: "Airbnb", color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Enter task title',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                      var task = Task(
                        id: IdGenerator.generateId(),
                        title: titleController.text,
                      );
                      context.read<TasksBloc>().add(AddTask(task: task));
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
