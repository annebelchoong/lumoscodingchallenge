// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lumoscodingchallenge/domain/todo.dart';

// enum SortingOrder { ascending, descending }

// class DataModel extends ChangeNotifier {
//   final List<Todo> _todoList = [];
//   SortingOrder _sortingOrder = SortingOrder.ascending;

//   int get length => _todoList.length;

//   Todo get(int index) => _todoList[index];

//   UnmodifiableListView<Todo> get todo => UnmodifiableListView(_todoList);

//   void add(Todo todo) {
//     _todoList.add(todo);
//     notifyListeners();
//   }

//   void remove(int index) {
//     _todoList.removeAt(index);
//     notifyListeners();
//   }

//   void removeAll() {
//     _todoList.clear();
//     notifyListeners();
//   }

//   void toggle(int index) {
//     _todoList[index] =
//         _todoList[index].copyWith(isDone: !_todoList[index].isDone);
//     notifyListeners();
//   }

//   void sort() {
//     if (_sortingOrder == SortingOrder.ascending) {
//       _todoList.sort((a, b) => a.title.compareTo(b.title));
//       _sortingOrder = SortingOrder.descending;
//     } else {
//       _todoList.sort((a, b) => b.title.compareTo(a.title));
//       _sortingOrder = SortingOrder.ascending;
//     }
//     notifyListeners();
//   }
// }

// final todoListProvider = ChangeNotifierProvider(
//   (_) => DataModel(),
// );
