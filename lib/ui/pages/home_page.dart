import 'package:backdrop/backdrop.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/export_providers.dart';
import '../../utils/hooks/scroll_controller_hook.dart';
import '../../utils/unique_keys.dart';
import '../widgets/app_title_with_transition.dart';
import '../widgets/todo_item.dart';
import '../widgets/toolbar.dart';
import 'back_layer_page.dart';

class Home extends StatefulHookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(todoListProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    void _toggleDarkMode() {
      ref.read(isDarkProvider.notifier).toggleTheme();
    }

    AnimationController mainTitleAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    AnimationController appbarTitleAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 0);
    ScrollController scrollController = useControllerForAnimation(
        mainTitleAnimController, appbarTitleAnimController);
    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = ref.watch(isDarkProvider).getTheme();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).colorScheme.primary,
        backLayerBackgroundColor: Theme.of(context).colorScheme.primary,
        headerHeight: 0,
        frontLayerBorderRadius: BorderRadius.circular(0),
        stickyFrontLayer: true,
        frontLayerScrim: isDark ? Colors.black54 : Colors.white60,
        backLayerScrim: isDark ? Colors.white54 : Colors.black54,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: BackdropAppBar(
          centerTitle: true,
          title: AppTitleWithTransition(
            appbarTitleAnimController,
          ),
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              CarbonIcons.task,
              size: 32,
            ),
          ),
          actions: [
            BackdropToggleButton(
              color: isDark ? Colors.white : Colors.black,
              icon: AnimatedIcons.close_menu,
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        backLayer: const BackLayerPage(),
        frontLayer: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            AppTitleWithTransition(
              mainTitleAnimController,
              fontSize: textTheme.headline1?.fontSize,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration:
                  const InputDecoration(labelText: 'What needs to be done?'),
              onSubmitted: (value) {
                ref.read(todoListProvider.notifier).add(value);
                newTodoController.clear();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '${ref.watch(uncompletedTodoCount).toString()} of ${ref.watch(totalTodoCount).toString()} items left',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            ToolBar(filter: ref.watch(todoFilterType.state)),
            if (todos.data.isEmpty) ...[
              const SizedBox(
                height: 24,
              ),
              Image.asset(
                'assets/images/empty_light.png',
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'No Task available!\n Try to add a new one.',
                textAlign: TextAlign.center,
              ),
            ],
            for (var i = 0; i < todos.data.length; i++) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Dismissible(
                  key: ValueKey(todos.data[i].id),
                  onDismissed: (_) {
                    ref.read(todoListProvider.notifier).remove(todos.data[i]);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text("Task Deleted!"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                  },
                  child: ProviderScope(
                    overrides: [
                      if (ref.watch(totalTodoCount) != 0)
                        currentTodo.overrideWithValue(todos.data[i])
                    ],
                    child: const TodoItem(),
                  ),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
