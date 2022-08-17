import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

class DataModel {
  DataModel({
    this.id = 0,
    required this.name,
    required this.kritName,
  });

  int id;
  String name;
  String kritName;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        kritName: json['kritName'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        'kritName': kritName,
      };
}
