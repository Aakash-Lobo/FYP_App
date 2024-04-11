import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskManagerPage extends StatefulWidget {
  final String username;

  TaskManagerPage({required this.username});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskManagerPage> {
  late Future<List<Map<String, String>>> _taskFuture;

  @override
  void initState() {
    super.initState();
    _taskFuture = fetchTasks();
  }

  Future<List<Map<String, String>>> fetchTasks() async {
    final response = await http.get(Uri.parse(
        'http://localhost/fyp/app/roles/viewtask.php?username=${widget.username}'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, String>> taskList = [];

      for (var item in responseData) {
        taskList.add({
          'name': item['task_name'].toString(),
          'priority': item['priority'].toString(),
          'deadline': item['deadline'].toString(),
        });
      }

      return taskList;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasks',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Map<String, String>>>(
            future: _taskFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return TaskTile(
                      name: snapshot.data![index]['name']!,
                      priority: snapshot.data![index]['priority']!,
                      deadline: snapshot.data![index]['deadline']!,
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskPage(username: widget.username),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String name;
  final String priority;
  final String deadline;

  TaskTile({
    required this.name,
    required this.priority,
    required this.deadline,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('Priority: $priority, Deadline: $deadline'),
      onTap: () {
        // Handle tile tap if needed
      },
    );
  }
}

class AddTaskPage extends StatefulWidget {
  final String username;

  AddTaskPage({required this.username});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  Future<void> addTask() async {
    final response = await http.post(
      Uri.parse('http://localhost/fyp/app/roles/addtask.php'),
      body: {
        'task_name': taskNameController.text,
        'task_description': taskDescriptionController.text,
        'priority': priorityController.text,
        'deadline': deadlineController.text,
        'username': widget.username,
      },
    );
    if (response.statusCode == 200) {
      // Task added successfully, you can navigate back or show a success message
    } else {
      throw Exception('Failed to add task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(
              labelText: 'Task Name',
              controller: taskNameController,
            ),
            SizedBox(height: 10),
            InputField(
              labelText: 'Task Description',
              controller: taskDescriptionController,
            ),
            SizedBox(height: 10),
            InputField(
              labelText: 'Priority',
              controller: priorityController,
            ),
            SizedBox(height: 10),
            InputField(
              labelText: 'Deadline',
              controller: deadlineController,
            ),
            SizedBox(height: 20),
            FormButton(
              text: 'Add Task',
              onPressed: addTask,
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const InputField({
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue, // Focused border color
            width: 2.0, // Focused border width
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FormButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        primary: Colors.blue, // Button background color
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Raleway',
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}
