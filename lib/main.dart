import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/shared_utility_provider.dart';
import 'providers/storage_provider.dart';
import 'providers/theme_provider.dart';
import 'ui/pages/home_page.dart';
import 'utils/storage.dart';
import 'utils/styles/task_app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final storage = LocalStorage();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        storageProvider.overrideWithValue(storage),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final bool isDark = ref.watch(isDarkProvider).getTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? TaskAppTheme.dark() : TaskAppTheme.light(),
          home: const Home(),
        );
      },
    );
  }
}
