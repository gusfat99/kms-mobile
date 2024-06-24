import 'dart:convert';

ReferensiModel referensiModelFromJson(String str) {
    final jsonData = json.decode(str);
    return ReferensiModel.fromJson(jsonData);
}

String referensiModelToJson(ReferensiModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class ReferensiModel {
    int count;
    Links links;
    PageContext pageContext;
    List<ReferensiResult> results;

    ReferensiModel({
        required this.count,
        required this.links,
        required this.pageContext,
        required this.results,
    });

    factory ReferensiModel.fromJson(Map<String, dynamic> json) => ReferensiModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results: List<ReferensiResult>.from(json["results"].map((x) => ReferensiResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "page_context": pageContext.toJson(),
        "results":  List<dynamic>.from(results.map((x) => x.toJson())),
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

class ReferensiResult {
    String createdAt;
    dynamic deletedAt;
    int id;
    String referensi;
    String updatedAt;

    ReferensiResult({
        required this.createdAt,
        this.deletedAt,
        required this.id,
        required this.referensi,
        required this.updatedAt,
    });

    factory ReferensiResult.fromJson(Map<String, dynamic> json) => ReferensiResult(
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
