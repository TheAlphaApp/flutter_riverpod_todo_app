import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/list_of_todo_model.dart';
import 'todo_filter_type_provider.dart';
import 'todo_list_provider.dart';

final filteredTodos = Provider<ListOfTodoModel>((ref) {
  final filter = ref.watch(todoFilterType.state);
  final todos = ref.watch(todoListProvider);

  switch (filter.state) {
    case TodoFilterType.completed:
      return ListOfTodoModel(
        data: todos.data.where((todo) => todo.isCompleted).toList(),
      );

    case TodoFilterType.active:
      return ListOfTodoModel(
        data: todos.data.where((todo) => !todo.isCompleted).toList(),
      );
    case TodoFilterType.pinned:
      return ListOfTodoModel(
        data: todos.data.where((todo) => todo.isPinned).toList(),
      );
    case TodoFilterType.all:
      return todos;
  }
});
