import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod_todo_app/providers/shared_utility_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isDarkProvider = ChangeNotifierProvider<DarkThemeNotifier>((ref) {
  return DarkThemeNotifier(ref);
});

class DarkThemeNotifier extends ChangeNotifier {
  DarkThemeNotifier(this.ref);
  ProviderRefBase ref;
  bool getTheme() {
    return ref.watch(sharedUtilityProvider).isDarkModeEnabled();
  }

  void toggleTheme() {
    ref.watch(sharedUtilityProvider).setDarkModeEnabled(
          !ref.watch(sharedUtilityProvider).isDarkModeEnabled(),
        );
    notifyListeners();
  }
}
