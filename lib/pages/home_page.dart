import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks_app/pages/todo_tile.dart';
import 'package:your_tasks_app/providers/todo-provider.dart';
import 'package:your_tasks_app/widgets/todo-dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    double bodyRadius = 40;
    final appBarTitleStyle = theme.textTheme.displaySmall!
        .copyWith(fontFamily: "Pacifico", color: colorScheme.onInverseSurface);
    final titleStyle =
        theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500);

    final todoProvider = Provider.of<TodoProvider>(context);
    final todoList = todoProvider.list;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TodoList", style: appBarTitleStyle),
        backgroundColor: colorScheme.inversePrimary,
        toolbarHeight: 120,
      ),
      body: Stack(
        children: [
          Container(
            color: colorScheme.inversePrimary,
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bodyRadius),
                topRight: Radius.circular(bodyRadius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "All Your Tasks : ",
                    style: titleStyle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                        colorScheme: colorScheme,
                        index: index,
                        taskName: todoList[index].taskName,
                        completed: todoList[index].completed,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 155, horizontal: 10),
            child: FloatingActionButton(
              mini: true,
              tooltip: "Let's add a task !",
              onPressed: () => showDialog(
                context: context,
                builder: (context) => TodoDialog(),
              ),
              backgroundColor: colorScheme.inversePrimary,
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
