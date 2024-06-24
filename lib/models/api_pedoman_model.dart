
import 'dart:convert';

PedomanModel pedomanModelFromJson(String str) {
    final jsonData = json.decode(str);
    return PedomanModel.fromJson(jsonData);
}

String pedomanModelToJson(PedomanModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PedomanModel {
    int count;
    Links links;
    PageContext pageContext;
    List<PedomanResult> results;

    PedomanModel({
        required this.count,
        required this.links,
        required this.pageContext,
        required this.results,
    });

    factory PedomanModel.fromJson(Map<String, dynamic> json) => PedomanModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results:  List<PedomanResult>.from(json["results"].map((x) => PedomanResult.fromJson(x))),
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

class PedomanResult {
    String createdAt;
    TedBy createdBy;
    String data;
    TedBy deletedBy;
    int id;
    String nama;
    String updatedAt;
    TedBy updatedBy;

    PedomanResult({
        required this.createdAt,
        required this.createdBy,
        required this.data,
        required this.deletedBy,
        required this.id,
        required this.nama,
        required this.updatedAt,
        required this.updatedBy,
    });

    factory PedomanResult.fromJson(Map<String, dynamic> json) => PedomanResult(
        createdAt: json["created_at"],
        createdBy: TedBy.fromJson(json["created_by"]),
        data: json["data"],
        deletedBy: TedBy.fromJson(json["deleted_by"]),
        id: json["id"],
        nama: json["nama"],
        updatedAt: json["updated_at"],
        updatedBy: TedBy.fromJson(json["updated_by"]),
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "created_by": createdBy.toJson(),
        "data": data,
        "deleted_by": deletedBy.toJson(),
        "id": id,
        "nama": nama,
        "updated_at": updatedAt,
        "updated_by": updatedBy.toJson(),
    };
}

class TedBy {
    dynamic id;
    dynamic username;

    TedBy({
        this.id,
        this.username,
    });

    factory TedBy.fromJson(Map<String, dynamic> json) => TedBy(
        id: json["id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}
