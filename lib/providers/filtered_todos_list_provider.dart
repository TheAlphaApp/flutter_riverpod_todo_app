import 'package:flutter_riverpod_todo_app/models/list_of_todo_model.dart';
import 'package:flutter_riverpod_todo_app/providers/todo_filter_type_provider.dart';
import 'package:flutter_riverpod_todo_app/providers/todo_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    case TodoFilterType.favourite:
      return ListOfTodoModel(
        data: todos.data.where((todo) => todo.isFavourite).toList(),
      );
    case TodoFilterType.all:
      return todos;
  }
});
