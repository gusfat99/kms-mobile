import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) {
  final jsonData = json.decode(str);
  return FeedbackModel.fromJson(jsonData);
}

String feedbackModelToJson(FeedbackModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class FeedbackModel {
  int count;
  Links links;
  PageContext pageContext;
  List<FeedbackModelResult> results;

  FeedbackModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.results,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        results: List<FeedbackModelResult>.from(
            json["results"].map((x) => FeedbackModelResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "page_context": pageContext.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class FeedbackModelResult {
  String createdAt;
  Forum forum;
  int id;
  LeaderTalk leaderTalk;
  LibraryCafe libraryCafe;
  Pengetahuan pengetahuan;
  String updatedAt;
  UserFeedback user;
  String? komentar;
  ParentKomentar? parentKomentar;
  dynamic status;

  FeedbackModelResult(
      {required this.createdAt,
      required this.forum,
      required this.id,
      required this.leaderTalk,
      required this.libraryCafe,
      required this.pengetahuan,
      required this.updatedAt,
      required this.user,
      this.status,
      this.komentar,
      this.parentKomentar});
  factory FeedbackModelResult.fromJson(Map<String, dynamic> json) =>
      FeedbackModelResult(
          createdAt: json['created_at'],
          forum: Forum.fromJson(json['forum']),
          id: json['id'],
          leaderTalk: LeaderTalk.fromJson(json['leader_talk']),
          libraryCafe: LibraryCafe.fromJson(json['library_cafe']),
          pengetahuan: Pengetahuan.fromJson(json['pengetahuan']),
          updatedAt: json['updated_at'],
          user: UserFeedback.fromJson(json['user']),
          komentar: json['komentar'],
          parentKomentar: json['parent_komentar'] != null
              ? ParentKomentar.fromJson(json['parent_komentar'])
              : null);

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "forum": forum,
        "id": id,
        "leader_talk": leaderTalk.toJson(),
        "library_cafe": libraryCafe.toJson(),
        "pengetahuan": pengetahuan.toJson(),
        "updated_at": updatedAt,
        "user": user,
        "komentar": komentar,
        "parent_komentar": parentKomentar?.toJson()
      };
}

class ParentKomentar {
  int? id;
  String? komentar;
  String? status;

  ParentKomentar({required this.id, this.komentar, this.status});

  factory ParentKomentar.fromJson(Map<String, dynamic> json) => ParentKomentar(
      id: json['id'], komentar: json['komentar'], status: json['status']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'komentar': komentar,
        'status': status,
      };
}

class Forum {
  int? id;

  Forum({this.id});

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(id: json['id']);

  Map<String, dynamic> toJson() => {"id": id};
}

class LeaderTalk {
  int? id;

  LeaderTalk({this.id});

  factory LeaderTalk.fromJson(Map<String, dynamic> json) =>
      LeaderTalk(id: json['id']);
  Map<String, dynamic> toJson() => {"id": id};
}

class LibraryCafe {
  int? id;

  LibraryCafe({required this.id});

  factory LibraryCafe.fromJson(Map<String, dynamic> json) =>
      LibraryCafe(id: json['id']);
  Map<String, dynamic> toJson() => {"id": id};
}

class Pengetahuan {
  int? id;

  Pengetahuan({this.id});

  factory Pengetahuan.fromJson(Map<String, dynamic> json) =>
      Pengetahuan(id: json['id']);
  Map<String, dynamic> toJson() => {"id": id};
}

class UserFeedback {
  String email;
  Foto foto;
  int id;
  String? jabatan;
  String namaLengkap;
  String namaPanggilan;
  String? nip;
  String? statusLevel;
  String? unitKerja;
  String? userLevel;
  String username;

  UserFeedback({
    required this.email,
    required this.foto,
    required this.id,
    this.jabatan,
    required this.namaLengkap,
    required this.namaPanggilan,
    this.nip,
    this.statusLevel,
    this.unitKerja,
    this.userLevel,
    required this.username,
  });

  factory UserFeedback.fromJson(Map<String, dynamic> json) => UserFeedback(
        email: json['email'],
        foto: Foto.fromJson(json['foto']),
        id: json['id'],
        jabatan: json['jabatan'],
        namaLengkap: json['nama_lengkap'],
        namaPanggilan: json['nama_panggilan'],
        nip: json['nip'],
        statusLevel: json['status_level'],
        unitKerja: json['unit_kerja'],
        userLevel: json['user_level'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'foto': foto.toJson(),
        'id': id,
        'jabatan': jabatan,
        'nama_lengkap': namaLengkap,
        'nama_panggilan': namaPanggilan,
        'nip': nip,
        'status_level': statusLevel,
        'unit_kerja': unitKerja,
        'user_level': userLevel,
        'username': username,
      };
}

class Foto {
  int? id;
  String? nama;
  String? url;

  Foto({this.id, this.nama, this.url});

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: json['id'],
        nama: json['nama'],
        url: json['url'],
      );
  Map<String, dynamic> toJson() => {"id": id, "nama": nama, "url": url};
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
