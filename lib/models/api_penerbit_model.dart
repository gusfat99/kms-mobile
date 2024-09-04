import 'dart:convert';

PenerbitModel PenerbitModelFromJson(String str) {
  final jsonData = json.decode(str);
  return PenerbitModel.fromJson(jsonData);
}

String PenerbitModelToJson(PenerbitModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PenerbitModel {
  int count;
  Links links;
  PageContext pageContext;
  List<PenerbitResult> results;

  PenerbitModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.results,
  });

  factory PenerbitModel.fromJson(Map<String, dynamic> json) => PenerbitModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results: List<PenerbitResult>.from(
            json["results"].map((x) => PenerbitResult.fromJson(x))),
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

class PenerbitResult {
  String createdAt;
  int id;
  String namaPenerbit;
  String updatedAt;

  PenerbitResult(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.namaPenerbit});

  factory PenerbitResult.fromJson(Map<String, dynamic> json) => PenerbitResult(
        createdAt: json["created_at"] ?? "",
        id: json["id"],
        namaPenerbit: json["nama"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "id": id,
        "nama_penerbit": namaPenerbit,
        "updated_at": updatedAt,
      };
}

class Foto {
  dynamic id;
  String nama;
  String url;

  Foto({
    required this.id,
    required this.nama,
    required this.url,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: json["id"] ?? "",
        nama: json["nama"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "url": url,
      };
}
