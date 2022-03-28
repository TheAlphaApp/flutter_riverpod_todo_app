import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/todo_filter_type_provider.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.title,
    required this.buttonFilter,
    required this.tooltipKey,
    required this.filter,
    Key? key,
  }) : super(key: key);
  final String title;
  final TodoFilterType buttonFilter;
  final UniqueKey tooltipKey;
  final StateController<TodoFilterType> filter;
  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color nonActiveColor = Theme.of(context).colorScheme.secondary;
    Color? textColorFor(TodoFilterType value) {
      return filter.state == value ? nonActiveColor : activeColor;
    }

    Color? backgroundColorFor(TodoFilterType value) {
      return filter.state == value ? activeColor : Colors.transparent;
    }

    return Tooltip(
      key: tooltipKey,
      message: title,
      child: TextButton(
        onPressed: () => filter.state = buttonFilter,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            Theme.of(context).textTheme.button,
          ),
          visualDensity: VisualDensity.compact,
          foregroundColor: MaterialStateProperty.all(
            textColorFor(buttonFilter),
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.transparent,
          ),
          backgroundColor: MaterialStateProperty.all(
            backgroundColorFor(buttonFilter),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
