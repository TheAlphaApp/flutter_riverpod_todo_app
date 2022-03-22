import 'todo_model.dart';

class ListOfTodoModel {
  late List<TodoModel> data;

  ListOfTodoModel({
    required this.data,
  });
  ListOfTodoModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <TodoModel>[];
      v.forEach((v) {
        arr0.add(TodoModel.fromJson(v));
      });
      data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    final v = this.data;
    final arr0 = [];
    for (var v in v) {
      arr0.add(v.toJson());

      data["data"] = arr0;
    }
    return data;
  }
}
