import 'package:hive/hive.dart';

part 'todo-model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  TodoModel(this.taskName, this.completed);

  @HiveField(0)
  final String taskName;

  @HiveField(1)
  final bool completed;

  @override
  bool operator ==(Object other) {
    if (other is! TodoModel) return false;
    if (other.taskName != taskName) return false;
    if (other.completed != completed) return false;
    return true;
  }
}
