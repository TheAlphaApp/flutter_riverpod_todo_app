class TodoModel {
  late String id;
  late String description;
  late bool isCompleted;
  late bool isPinned;

  TodoModel({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.isPinned = false,
  });
  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    description = json["description"].toString();
    isCompleted = json["isCompleted"] ?? false;
    isPinned = json["isPinned"] ?? false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["isCompleted"] = isCompleted;
    data["isPinned"] = isPinned;
    return data;
  }
}
