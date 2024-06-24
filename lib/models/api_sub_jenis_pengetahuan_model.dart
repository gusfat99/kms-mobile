import 'dart:convert';

SubJenisPengetahuanModel subJenisPengetahuanModelFromJson(String str) {
  final jsonData = json.decode(str);
  return SubJenisPengetahuanModel.fromJson(jsonData);
}

String subJenisPengetahuanModelToJson(SubJenisPengetahuanModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class SubJenisPengetahuanModel {
  int count;
  Links links;
  PageContext pageContext;
  List<SubJenisPengetahuanResult> results;

  SubJenisPengetahuanModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.results,
  });

  factory SubJenisPengetahuanModel.fromJson(Map<String, dynamic> json) =>
      SubJenisPengetahuanModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results: List<SubJenisPengetahuanResult>.from(
            json["results"].map((x) => SubJenisPengetahuanResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "page_context": pageContext.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
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

class SubJenisPengetahuanResult {
  dynamic createdAt;
  int id;
  String nama;
  dynamic updatedAt;

  SubJenisPengetahuanResult({
    this.createdAt,
    required this.id,
    required this.nama,
    this.updatedAt,
  });

  factory SubJenisPengetahuanResult.fromJson(Map<String, dynamic> json) =>
      SubJenisPengetahuanResult(
        createdAt: json["created_at"],
        id: json["id"],
        nama: json["nama"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "id": id,
        "nama": nama,
        "updated_at": updatedAt,
      };
}

class JenisPengetahuan {
  int id;
  String nama;

  JenisPengetahuan({
    required this.id,
    required this.nama,
  });

  factory JenisPengetahuan.fromJson(Map<String, dynamic> json) =>
      JenisPengetahuan(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
