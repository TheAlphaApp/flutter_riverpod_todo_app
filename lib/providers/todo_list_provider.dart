import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/list_of_todo_model.dart';
import '../models/todo_model.dart';
import 'shared_utility_provider.dart';

const _uuid = Uuid();
final todoListProvider = StateNotifierProvider<TodoList, ListOfTodoModel>(
  (ref) {
    final shareutil = ref.watch(sharedUtilityProvider);
    return TodoList(ListOfTodoModel(data: []), shareutil);
  },
);

class TodoList extends StateNotifier<ListOfTodoModel> {
  TodoList(ListOfTodoModel initialTodos, this.sharedUtility)
      : super(
          initialTodos,
        );
  final SharedUtility sharedUtility;

  void overrideData(ListOfTodoModel listOfTodoModel) {
    if (listOfTodoModel.data.isNotEmpty) {
      state = listOfTodoModel;
    }
  }

  void saveData() {
    sharedUtility.saveSharedTodoData(state);
  }

  void loadData() {
    final data = sharedUtility.loadSharedTodoData();
    state = data;
  }

  /// Adds a new [TodoModel] to the list.
  void add(String description) {
    state = ListOfTodoModel(data: [
      ...state.data,
      TodoModel(id: _uuid.v4(), description: description),
    ]);
    saveData();
  }

// Toggle favourite
  void togglePinned(String id) async {
    state = ListOfTodoModel(data: [
      for (final todo in state.data)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            isCompleted: todo.isCompleted,
            isPinned: !todo.isPinned,
          )
        else
          todo,
    ]);
    saveData();
  }

  /// Toggle the state of [TodoModel].
  void toggle(String id) {
    state = ListOfTodoModel(data: [
      for (final todo in state.data)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            isCompleted: !todo.isCompleted,
            isPinned: todo.isPinned,
          )
        else
          todo,
    ]);
    saveData();
  }

  /// Edit the description of [TodoModel].
  void edit({required String id, required String description}) {
    state = ListOfTodoModel(data: [
      for (final todo in state.data)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: description,
            isCompleted: todo.isCompleted,
            isPinned: todo.isPinned,
          )
        else
          todo,
    ]);
    saveData();
  }

  /// Removes a [TodoModel] from the list.

  void remove(TodoModel target) {
    state = ListOfTodoModel(
        data: state.data.where((todo) => todo.id != target.id).toList());

    saveData();
  }

  /// Reorders the list by moving an item from [oldIndex] to [newIndex].
  ///
  /// This method takes the [oldIndex] and [newIndex] as parameters and
  /// reorders the list accordingly. It retrieves the list of items from
  /// the current state, removes the item at the [oldIndex], and inserts
  /// it at the [newIndex]. Finally, it updates the state with the new
  /// list and saves the data.
  void reorder(int oldIndex, int newIndex) {
    /// If the new index is greater than the old index, we need to subtract 1 from the new index.
    /// This is because when we remove the item from the old index, the items below it will shift up by one.
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = state.data;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = ListOfTodoModel(data: items);
    saveData();
  }
}
