import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks_app/widgets/todo-dialog.dart';

import '../providers/todo-provider.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.colorScheme,
    required this.index,
    required this.taskName,
    required this.completed,
  });

  final ColorScheme colorScheme;
  final int index;
  final String taskName;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        key: Key("todoTile_$index$taskName$completed"),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) => todoProvider.removeTask(index, context),
        child: Card(
          shadowColor: colorScheme.inversePrimary,
          elevation: 5,
          child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              title: Center(
                  child: Text(
                taskName,
                style: TextStyle(
                    decoration: completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )),
              leading: Checkbox(
                value: completed,
                onChanged: (completed) =>
                    todoProvider.toggleCompleted(index, completed!),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Edit button
                  IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: colorScheme.inversePrimary),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => TodoDialog(
                          add: false, index: index, taskName: taskName),
                    ),
                    icon:
                        Icon(Icons.edit_outlined, color: colorScheme.onSurface),
                  ),
                  const SizedBox(width: 10),
                  //Delete button
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => todoProvider.removeTask(index, context),
                    icon: const Icon(Icons.delete_outline, color: Colors.white),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
