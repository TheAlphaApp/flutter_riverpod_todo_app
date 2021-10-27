import 'package:flutter_riverpod_todo_app/models/todo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// By retreiving the [TodoModel] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
/// This ensures that when we add/remove/edit todos, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
final currentTodo = Provider<TodoModel>((ref) => throw UnimplementedError());
