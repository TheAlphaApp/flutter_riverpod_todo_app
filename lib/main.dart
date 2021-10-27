import 'package:flutter/material.dart';
import 'package:flutter_riverpod_todo_app/providers/theme_provider.dart';
import 'package:flutter_riverpod_todo_app/providers/shared_utility_provider.dart';
import 'package:flutter_riverpod_todo_app/ui/pages/home_page.dart';
import 'package:flutter_riverpod_todo_app/utils/styles/task_app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final bool isDark = ref.watch(isDarkProvider).getTheme();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? TaskAppTheme.dark() : TaskAppTheme.light(),
        home: const Home(),
      );
    });
  }
}
