import 'dart:convert';

NewTagModel newTagModelFromJson(String str) {
  final jsonData = json.decode(str);
  return NewTagModel.fromJson(jsonData);
}

String newTagModelToJson(NewTagModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class NewTagModel {
  String createdAt;
  dynamic deletedAt;
  int id;
  String nama;
  String updatedAt;

  NewTagModel({
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.nama,
    required this.updatedAt,
  });

  factory NewTagModel.fromJson(Map<String, dynamic> json) => NewTagModel(
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        id: json["id"],
        nama: json["nama"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "id": id,
        "nama": nama,
        "updated_at": updatedAt,
      };
}
