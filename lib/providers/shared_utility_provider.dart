import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/list_of_todo_model.dart';
import '../utils/constants.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final _sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: _sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  ListOfTodoModel loadSharedTodoData() {
    Map<String, dynamic> decodeOptions = jsonDecode(
        sharedPreferences.getString(sharedPrefTodoListKey) ??
            emptyJsonStringData);
    ListOfTodoModel listOfTodoModel = ListOfTodoModel.fromJson(decodeOptions);
    return listOfTodoModel;
  }

  void saveSharedTodoData(ListOfTodoModel listOfTodoModel) {
    if (listOfTodoModel.data.isNotEmpty) {
      Map<String, dynamic> decodeOptions = listOfTodoModel.toJson();
      String sharedData = jsonEncode(
        ListOfTodoModel.fromJson(decodeOptions),
      );
      sharedPreferences.setString(sharedPrefTodoListKey, sharedData);
    } else {
      sharedPreferences.setString(sharedPrefTodoListKey, emptyJsonStringData);
    }
  }

  bool isDarkModeEnabled() {
    return sharedPreferences.getBool(sharedDarkModeKey) ?? false;
  }

  void setDarkModeEnabled(bool value) {
    sharedPreferences.setBool(sharedDarkModeKey, value);
  }
}
