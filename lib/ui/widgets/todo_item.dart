import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_todo_app/providers/current_todo_provider.dart';
import 'package:flutter_riverpod_todo_app/providers/todo_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(currentTodo);
    //hooks
    final itemFocusNode = useFocusNode();
    // listen to focus chances
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.45),
          width: 1,
        ),
      ),
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: GestureDetector(
            onTap: () => ref.read(todoListProvider.notifier).toggle(todo.id),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: todo.isCompleted
                  ? Icon(
                      Icons.check_circle,
                      size: 32.0,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      size: 32.0,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.45),
                    ),
            ),
          ),
          title: isFocused
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                      autofocus: true,
                      focusNode: textFieldFocusNode,
                      controller: textEditingController,

                      ///due to bug in indic keyboard . It fills suggestion automatically two times.
                      enableSuggestions: false,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration:
                          const InputDecoration(labelText: 'Edit Task')),
                )
              : Text(
                  todo.description,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
          trailing: GestureDetector(
            onTap: () =>
                ref.read(todoListProvider.notifier).toggleFavourite(todo.id),
            child: todo.isFavourite
                ? Icon(
                    Icons.star_rate_rounded,
                    size: 32,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                : Icon(
                    Icons.star_border_rounded,
                    size: 32,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.45), //
                  ),
          ),
        ),
      ),
    );
  }
}
