import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

class DataModel {
  DataModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
