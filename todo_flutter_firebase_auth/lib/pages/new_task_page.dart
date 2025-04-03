// TODO create a stateful widget that returns the description.
import 'package:flutter/material.dart';
import 'package:todo_flutter/controllers/task_controller.dart';

class NewTaskPage extends StatefulWidget {

  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();

}

class _NewTaskPageState extends State<NewTaskPage> {

  final _taskController = TaskController();
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the  controller when the widget is disposed
    _textController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
            'Add new Task',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'New Task'
                    ),
                    validator: (value) {
                      if(value!.isEmpty || value==null) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                  )
                ],
              )
            ),
            ElevatedButton(
                onPressed: () => {
                  if(_formKey.currentState!.validate()) {
                    _taskController.insertTask(_textController.text),
                    Navigator.pop(context)
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16
                  ),
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                child: Text('Add task')
            )
          ],
        ),
      )
    );
  }

}