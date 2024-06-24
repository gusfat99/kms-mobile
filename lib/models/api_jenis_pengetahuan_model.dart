import 'dart:convert';

JenisPengetahuanModel jenisPengetahuanModelFromJson(String str) {
  final jsonData = json.decode(str);
  return JenisPengetahuanModel.fromJson(jsonData);
}

String jenisPengetahuanModelToJson(JenisPengetahuanModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class JenisPengetahuanModel {
  int count;
  Links links;
  PageContext pageContext;
  List<JenisPengetahuanResult> results;

  JenisPengetahuanModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.results,
  });

  factory JenisPengetahuanModel.fromJson(Map<String, dynamic> json) =>
      JenisPengetahuanModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results:
            List<JenisPengetahuanResult>.from(json["results"].map((x) => JenisPengetahuanResult.fromJson(x))),
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

class JenisPengetahuanResult {
  String createdAt;
  int id;
  String nama;
  String updatedAt;

  JenisPengetahuanResult({
    required this.createdAt,
    required this.id,
    required this.nama,
    required this.updatedAt,
  });

  factory JenisPengetahuanResult.fromJson(Map<String, dynamic> json) => JenisPengetahuanResult(
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
