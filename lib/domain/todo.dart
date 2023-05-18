import 'package:flutter/foundation.dart' show immutable;

enum SortingOrder { ascending, descending }

final List<Todo> todoList = [];

@immutable
class Todo {
  final String title;
  final String subtitle;
  final bool isDone;

  // empty constructor
  Todo({
    required this.title,
    this.subtitle = '',
    required this.isDone,
  });

  Todo copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
    );
  }
}
