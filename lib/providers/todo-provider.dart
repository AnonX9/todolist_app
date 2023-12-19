import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:your_tasks_app/models/todo-model.dart';

import '../widgets/snackbar.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider();

  final Box<TodoModel> _todoList = Hive.box<TodoModel>("Tasks");

  List<TodoModel> get list => _todoList.values.toList();

  void addTask(String taskName, BuildContext context) async {
    TodoModel todo = TodoModel(taskName, false);
    if (_todoList.toMap().containsValue(todo)) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar("error", "This task already exists !"));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar("success", "New task successfully added !"));
      await _todoList.add(todo);
    }
    notifyListeners();
  }

  void removeTask(int index, BuildContext context) async {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(getSnackBar("success", "Task successfully deleted !"));
    await _todoList.deleteAt(index);
    notifyListeners();
  }

  void updateTask(int index, String taskName, BuildContext context) async {
    TodoModel todo = TodoModel(taskName, false);
    TodoModel todoDone = TodoModel(taskName, true);

    bool listContainTask = _todoList.toMap().containsValue(todo) ||
        _todoList.toMap().containsValue(todoDone);

    if (listContainTask) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar("error", "Please change the task !"));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar("success", "Task successfully modified !"));
      await _todoList.putAt(index, todo);
    }

    notifyListeners();
  }

  void toggleCompleted(int index, bool completed) async {
    TodoModel todo = TodoModel(list[index].taskName, completed);
    await _todoList.putAt(index, todo);
    notifyListeners();
  }
}
