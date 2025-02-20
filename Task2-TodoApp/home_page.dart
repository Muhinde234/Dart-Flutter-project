import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/new_task_page.dart';

import '../controllers/task_controller.dart';
import '../model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const title = 'Task Manager';
  final _stream = TaskController().getStream();
  final _taskController = TaskController();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: _stream,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(title)
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final tasks = snapshot.data ?? [];
        final hasCompletedTasks = tasks.any((task) => task.isCompleted);

        return Scaffold(
          appBar: AppBar(
              actions: [
                // Rendering the delete button only when it has completed tasks
                if(hasCompletedTasks)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      onPressed: () => _deleteCompletedTasks(tasks),
                      icon: const Icon(Icons.delete),
                      color: Colors.white,
                  ),
                )
              ],
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text(
                  title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),
              )
          ),
          body: ListView.separated(
            itemBuilder: (_, index) => _toWidget(tasks[index]),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const Divider(),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            foregroundColor: Colors.white,
            onPressed: () => {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const NewTaskPage())
              )
            },
            backgroundColor: Colors.indigoAccent,
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  Widget _toWidget(Task task) {
    return ListTile(
      title: Text(
        task.description,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          setState(() {
            task.isCompleted = value ?? false; // Toggle task completion
          });
        },
      ),
    );
  }

  void _deleteCompletedTasks(List<Task> tasks) {
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    for (Task task in completedTasks) {
      _taskController.removeTask(task);
    }
  }
}
