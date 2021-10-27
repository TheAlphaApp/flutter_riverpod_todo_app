
class TodoModel {
  late String id;
  late String description;
  late bool isCompleted;
  late bool isFavourite;

  TodoModel({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.isFavourite = false,
  });
  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    description = json["description"].toString();
    isCompleted = json["isCompleted"] ?? false;
    isFavourite = json["isFavourite"] ?? false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["isCompleted"] = isCompleted;
    data["isFavourite"] = isFavourite;
    return data;
  }
}
