import 'dart:convert';

PenulisModel penulisModelFromJson(String str) {
  final jsonData = json.decode(str);
  return PenulisModel.fromJson(jsonData);
}

String penulisModelToJson(PenulisModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PenulisModel {
  int count;
  Links links;
  PageContext pageContext;
  List<PenulisResult> results;

  PenulisModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.results,
  });

  factory PenulisModel.fromJson(Map<String, dynamic> json) => PenulisModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results: List<PenulisResult>.from(
            json["results"].map((x) => PenulisResult.fromJson(x))),
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

class PenulisResult {
  String createdAt;
  dynamic createdBy;
  dynamic deletedBy;
  String email;
  Foto foto;
  int id;
  String jabatan;
  String namaLengkap;
  String namaPanggilan;
  String nip;
  dynamic statusLevel;
  dynamic unitKerja;
  String updatedAt;
  dynamic updatedBy;
  dynamic userLevel;

  PenulisResult({
    required this.createdAt,
    this.createdBy,
    this.deletedBy,
    required this.email,
    required this.foto,
    required this.id,
    required this.jabatan,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.nip,
    this.statusLevel,
    this.unitKerja,
    required this.updatedAt,
    this.updatedBy,
    this.userLevel,
  });

  factory PenulisResult.fromJson(Map<String, dynamic> json) => PenulisResult(
        createdAt: json["created_at"] ?? "",
        createdBy: json["created_by"],
        deletedBy: json["deleted_by"],
        email: json["email"] ?? "",
        foto: Foto.fromJson(json["foto"]),
        id: json["id"],
        jabatan: json["jabatan"] ?? "",
        namaLengkap: json["nama_lengkap"] ?? "",
        namaPanggilan: json["nama_panggilan"] ?? "",
        nip: json["nip"] ?? "",
        statusLevel: json["status_level"] ?? "",
        unitKerja: json["unit_kerja"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        updatedBy: json["updated_by"] ?? "",
        userLevel: json["user_level"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "created_by": createdBy,
        "deleted_by": deletedBy,
        "email": email,
        "foto": foto.toJson(),
        "id": id,
        "jabatan": jabatan,
        "nama_lengkap": namaLengkap,
        "nama_panggilan": namaPanggilan,
        "nip": nip,
        "status_level": statusLevel,
        "unit_kerja": unitKerja,
        "updated_at": updatedAt,
        "updated_by": updatedBy,
        "user_level": userLevel,
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
        nama: json["nama"]  ?? "",
        url: json["url"]  ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "url": url,
      };
}
