import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);

  List<Task> taskList = [
    Task(title: "gym"),
    Task(title: "go to office"),
    Task(title: "make dinner"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const Text('Task List'),
            SizedBox(
              width: 176,
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
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                var task = taskList[index];
                return ListTile(
                    title: Text(task.title),
                    trailing: Checkbox(
                      value: task.isDone,
                      onChanged: (bool? value) {},
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
