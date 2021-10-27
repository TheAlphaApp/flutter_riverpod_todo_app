import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TodoFilterType {
  all,
  active,
  completed,
  favourite,
}

final todoFilterType = StateProvider((ref) => TodoFilterType.active);
