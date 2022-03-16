import 'package:flutter_riverpod_todo_app/providers/todo_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uncompletedTodoCount = Provider<int>(
  (ref) {
    return ref
        .watch(todoListProvider)
        .data
        .where((todo) => !todo.isCompleted)
        .length;
  },
);
final totalTodoCount = Provider<int>(
  (ref) {
    return ref.watch(todoListProvider).data.length;
  },
);
