import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lumoscodingchallenge/domain/todo.dart';
import 'package:lumoscodingchallenge/util/controllers.dart';

class EntryPage extends StatefulHookConsumerWidget {
  const EntryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryPageState();
}

final _formKey = GlobalKey<FormState>();

class _EntryPageState extends ConsumerState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    // final titleController = useTextEditingController();
    // final subtitleController = useTextEditingController();

    final onSubmit = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do Entry'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Enter Your to-do',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 16.0,
                  top: 16.0,
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter some text'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 16.0,
                  top: 16.0,
                ),
                child: TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(
                    labelText: 'Subtitle',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('To-do Entry Submitted')),
                    );
                    // pop keyboard off
                    FocusScope.of(context).unfocus();

                    setState(() {
                      todoList.add(
                        Todo(
                          title: titleController.text,
                          isDone: false,
                          subtitle: subtitleController.text,
                        ),
                      );
                    });
                    titleController.clear();
                    subtitleController.clear();
                    onSubmit.value = true;
                  }
                },
                child: const SizedBox(
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
