import 'dart:convert';

NewReferensiModel newReferensiModelFromJson(String str) {
    final jsonData = json.decode(str);
    return NewReferensiModel.fromJson(jsonData);
}

String newReferensiModelToJson(NewReferensiModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class NewReferensiModel {
    String createdAt;
    dynamic deletedAt;
    int id;
    String referensi;
    String updatedAt;

    NewReferensiModel({
        required this.createdAt,
        this.deletedAt,
        required this.id,
        required this.referensi,
        required this.updatedAt,
    });

    factory NewReferensiModel.fromJson(Map<String, dynamic> json) => NewReferensiModel(
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        id: json["id"],
        referensi: json["referensi"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "id": id,
        "referensi": referensi,
        "updated_at": updatedAt,
    };
}
