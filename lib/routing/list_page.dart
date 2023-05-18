import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lumoscodingchallenge/domain/todo.dart';
import 'package:lumoscodingchallenge/util/controllers.dart';

class ListPage extends StatefulHookConsumerWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageState();
}

final _formKey = GlobalKey<FormState>();

class _ListPageState extends ConsumerState<ListPage> {
  SortingOrder sortingOrder = SortingOrder.ascending;

  void _sortTodos(SortingOrder order) {
    setState(() {
      if (order == SortingOrder.ascending) {
        todoList.sort((a, b) => a.title.compareTo(b.title));
        sortingOrder = SortingOrder.descending;
      } else {
        todoList.sort((a, b) => a.title.compareTo(b.title));
        sortingOrder = SortingOrder.ascending;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final todoList = ref.watch(todoListProvider);
    // final datamodel = ref.read(todoListProvider);
    // var sortingOrder = SortingOrder.ascending;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // setState(() {
          //   addTodoDialog(
          //     context,
          //     titleController,
          //     subtitleController,
          //     ref,
          //   );
          // });
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
                          const SnackBar(
                              content: Text('To-do Entry Submitted')),
                        );
                        Navigator.pop(context);

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
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('To-do List'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () {
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Ascending'),
                  value: SortingOrder.ascending,
                ),
                const PopupMenuItem(
                  child: Text('Descending'),
                  value: SortingOrder.descending,
                ),
              ],
            );
            setState(() {
              todoList.sort((a, b) => a.title.compareTo(b.title));
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                todoList.clear();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList.elementAt(index);
            return Dismissible(
              key: Key(todo.title),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${todo.title} removed'),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
              ),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: todo.isDone
                    ? Text(
                        todo.title,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    : Text(todo.title),
                subtitle: todo.isDone
                    ? Text(
                        todo.subtitle,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    : Text(todo.subtitle),
                value: todo.isDone,
                onChanged: (value) {
                  todoList[index] = todo.copyWith(isDone: value);
                },
              ),
            );
          }),
    );
  }
}
