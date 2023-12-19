import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks_app/providers/todo-provider.dart';

class TodoDialog extends StatelessWidget {
  TodoDialog({super.key, this.add = true, this.index = -1, this.taskName = ""})
      : assert(add || (index != -1 && taskName != ""));
  final bool add;
  final int index;
  final String taskName;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final todoProvider = Provider.of<TodoProvider>(context);
    final TextEditingController textController =
        TextEditingController(text: add ? "" : taskName);

    return AlertDialog(
      shadowColor: colorScheme.inversePrimary,
      title: Text(add ? "Create a new Task !" : "Let's update it !"),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: textController,
          autofocus: true,
          decoration:
              const InputDecoration(border: OutlineInputBorder(), filled: true),
          validator: (value) =>
              value!.length < 3 ? "At least 3 characters required" : null,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            //Save Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.inversePrimary),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  add
                      ? todoProvider.addTask(textController.text, context)
                      : todoProvider.updateTask(
                          index, textController.text, context);

                  Navigator.pop(context);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onInverseSurface),
              ),
            ),
          ],
        )
      ],
    );
  }
}
