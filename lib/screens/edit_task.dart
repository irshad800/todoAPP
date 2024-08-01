import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/utils/colors.dart';

import '../bloc/task_bloc.dart';
import '../model/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;

  EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: oldTask.title);
    final detailController = TextEditingController(text: oldTask.details);
    DateTime? selectedDate = oldTask.dueDate;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
      }
    }

    void _saveTask() {
      final updatedTask = oldTask.copyWith(
        title: titleController.text,
        details: detailController.text,
        dueDate: selectedDate,
      );
      context.read<TasksBloc>().add(UpdateTask(task: updatedTask));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColors,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              "Edit Task",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter task title',
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter details',
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Date: ${selectedDate?.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "Choose Date",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _saveTask,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
