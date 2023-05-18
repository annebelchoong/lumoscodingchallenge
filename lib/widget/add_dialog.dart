import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lumoscodingchallenge/domain/todo.dart';

Future<Todo?> addTodoDialog(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController subtitleController,
  WidgetRef ref,
) async {
  final _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-do'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: titleController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter some text'
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(
                    labelText: 'Subtitle',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('To-do Entry Submitted')),
                  );
                  Navigator.pop(context);

                  todoList.add(
                    Todo(
                      title: titleController.text,
                      isDone: false,
                      subtitle: subtitleController.text,
                    ),
                  );
                  titleController.clear();
                  subtitleController.clear();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      });
}
