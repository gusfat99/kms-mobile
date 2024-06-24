import 'dart:convert';

PostAttachModel postAttachModelFromJson(String str) {
    final jsonData = json.decode(str);
    return PostAttachModel.fromJson(jsonData);
}

String postAttachModelToJson(PostAttachModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PostAttachModel {
    String createdAt;
    dynamic deletedAt;
    String extension;
    dynamic file;
    String filename;
    int id;
    int size;
    String storageLocation;
    String updatedAt;
    String url;

    PostAttachModel({
        required this.createdAt,
        this.deletedAt,
        required this.extension,
        this.file,
        required this.filename,
        required this.id,
        required this.size,
        required this.storageLocation,
        required this.updatedAt,
        required this.url,
    });

    factory PostAttachModel.fromJson(Map<String, dynamic> json) => PostAttachModel(
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        extension: json["extension"],
        file: json["file"],
        filename: json["filename"],
        id: json["id"],
        size: json["size"],
        storageLocation: json["storage_location"],
        updatedAt: json["updated_at"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "extension": extension,
        "file": file,
        "filename": filename,
        "id": id,
        "size": size,
        "storage_location": storageLocation,
        "updated_at": updatedAt,
        "url": url,
    };
}
