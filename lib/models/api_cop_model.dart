import 'dart:convert';

CopModel copModelFromJson(String str) {
  final jsonData = json.decode(str);
  return CopModel.fromJson(jsonData);
}

String copModelToJson(CopModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CopModel {
  int count;
  Links links;
  PageContext pageContext;
  List<CopResult> copResults;

  CopModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.copResults,
  });

  factory CopModel.fromJson(Map<String, dynamic> json) => CopModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        copResults: List<CopResult>.from(
            json["results"].map((x) => CopResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "page_context": pageContext.toJson(),
        "results": List<dynamic>.from(copResults.map((x) => x.toJson())),
      };
}

class Links {
  String first;
  String last;
  String next;
  String previous;

  Links({
    required this.first,
    required this.last,
    required this.next,
    required this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "next": next,
        "previous": previous,
      };
}

class PageContext {
  int page;
  int perPage;
  int totalPages;

  PageContext({
    required this.page,
    required this.perPage,
    required this.totalPages,
  });

  factory PageContext.fromJson(Map<String, dynamic> json) => PageContext(
        page: json["page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class CopResult {
  String createdAt;
  TedBy createdBy;
  TedBy deletedBy;
  String deskripsi;
  Dokumen dokumen;
  Dokumen gambar;
  int id;
  String judul;
  String kategori;
  Statistik statistik;
  String topik;
  String updatedAt;
  TedBy updatedBy;

  CopResult({
    required this.createdAt,
    required this.createdBy,
    required this.deletedBy,
    required this.deskripsi,
    required this.dokumen,
    required this.gambar,
    required this.id,
    required this.judul,
    required this.kategori,
    required this.statistik,
    required this.topik,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory CopResult.fromJson(Map<String, dynamic> json) => CopResult(
        createdAt: json["created_at"] ?? "",
        createdBy: TedBy.fromJson(json["created_by"]),
        deletedBy: TedBy.fromJson(json["deleted_by"]),
        deskripsi: json["deskripsi"] ?? "",
        dokumen: Dokumen.fromJson(json["dokumen"]),
        gambar: Dokumen.fromJson(json["gambar"]),
        id: json["id"] ?? "",
        judul: json["judul"] ?? "",
        kategori: json["kategori"] ?? "",
        statistik: Statistik.fromJson(json["statistik"]),
        topik: json["topik"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        updatedBy: TedBy.fromJson(json["updated_by"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "created_by": createdBy.toJson(),
        "deleted_by": deletedBy.toJson(),
        "deskripsi": deskripsi,
        "dokumen": dokumen.toJson(),
        "gambar": gambar.toJson(),
        "id": id,
        "judul": judul,
        "kategori": kategori,
        "statistik": statistik.toJson(),
        "topik": topik,
        "updated_at": updatedAt,
        "updated_by": updatedBy.toJson(),
      };
}

class TedBy {
  int id;
  String username;

  TedBy({
    required this.id,
    required this.username,
  });

  factory TedBy.fromJson(Map<String, dynamic> json) => TedBy(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}

class Dokumen {
  String filename;
  int id;
  String url;

  Dokumen({
    required this.filename,
    required this.id,
    required this.url,
  });

  factory Dokumen.fromJson(Map<String, dynamic> json) => Dokumen(
        filename: json["filename"] ?? "",
        id: json["id"] ?? 0,
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "id": id,
        "url": url,
      };
}

class Statistik {
  int dislike;
  int komentar;
  int like;
  int view;

  Statistik({
    required this.dislike,
    required this.komentar,
    required this.like,
    required this.view,
  });

  factory Statistik.fromJson(Map<String, dynamic> json) => Statistik(
        dislike: json["dislike"] ?? "",
        komentar: json["komentar"] ?? "",
        like: json["like"] ?? "",
        view: json["view"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "dislike": dislike,
        "komentar": komentar,
        "like": like,
        "view": view,
      };
}
