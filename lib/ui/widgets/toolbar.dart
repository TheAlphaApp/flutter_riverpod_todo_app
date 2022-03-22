import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/todo_filter_type_provider.dart';
import '../../utils/unique_keys.dart';
import 'category_button.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({required this.filter, Key? key}) : super(key: key);
  final StateController<TodoFilterType> filter;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Column(
          children: [
            Wrap(
              children: [
                CategoryButton(
                  title: 'All',
                  buttonFilter: TodoFilterType.all,
                  tooltipKey: allFilterKey,
                  filter: filter,
                ),
                CategoryButton(
                  title: 'Active',
                  buttonFilter: TodoFilterType.active,
                  tooltipKey: activeFilterKey,
                  filter: filter,
                ),
                CategoryButton(
                  title: 'Pinned',
                  buttonFilter: TodoFilterType.pinned,
                  tooltipKey: pinnedFilterKey,
                  filter: filter,
                ),
                CategoryButton(
                  title: 'Done',
                  buttonFilter: TodoFilterType.completed,
                  tooltipKey: completedFilterKey,
                  filter: filter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
