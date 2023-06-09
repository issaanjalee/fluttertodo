import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData.dark(),
      home: TodoScreen(),
    );
  }
}

class Task {
  String title;
  bool isCompleted;
  DateTime timeAdded;

  Task({
    required this.title,
    this.isCompleted = false,
    required this.timeAdded,
  });
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.insert(
        0,
        Task(
          title: title,
          timeAdded: DateTime.now(),
        ),
      );
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void deleteTaskAtIndex(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Create Task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newTaskTitle = '';

                        return AlertDialog(
                          title: Text('Add Task'),
                          content: TextField(
                            onChanged: (value) {
                              newTaskTitle = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Add'),
                              onPressed: () {
                                addTask(newTaskTitle);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle:
                      Text('Added: ${DateFormat.Hm().format(task.timeAdded)}'),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      toggleTaskCompletion(index);
                    },
                  ),
                  onLongPress: () {
                    deleteTaskAtIndex(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
