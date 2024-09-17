import 'dart:convert';

PengetahuanModel pengetahuanModelFromJson(String str) {
  final jsonData = json.decode(str);
  return PengetahuanModel.fromJson(jsonData);
}

String pengetahuanModelToJson(PengetahuanModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PengetahuanModel {
  int count;
  Links links;
  PageContext pageContext;
  List<PengetahuanResult> pengetahuanResults;

  PengetahuanModel({
    required this.count,
    required this.links,
    required this.pageContext,
    required this.pengetahuanResults,
  });

  factory PengetahuanModel.fromJson(Map<String, dynamic> json) =>
      PengetahuanModel(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        pageContext: PageContext.fromJson(json["page_context"]),
        pengetahuanResults: List<PengetahuanResult>.from(
            json["results"].map((x) => PengetahuanResult.fromJson(x))),
      );

  List<PengetahuanResult>? get results => null;

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "page_context": pageContext.toJson(),
        "results":
            List<dynamic>.from(pengetahuanResults.map((x) => x.toJson())),
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

class PengetahuanResult {
  String createdAt;
  TedBy createdBy;
  String dampak;
  String dasarHukum;
  String dataDigunakan;
  TedBy deletedBy;
  String hipotesis;
  int id;
  Pengetahuan jenisPengetahuan;
  String judul;
  int jumlahHalaman;
  String keahlianDibutuhkan;
  String kesimpulanRekomendasi;
  String latarBelakang;
  String lessonLearned;
  Pengetahuan lingkupPengetahuan;
  String masalah;
  String metodePengawasan;
  String pembahasan;
  String penelitianTerdahulu;
  String pengujian;
  Penulis penulis1;
  Penulis penulis2;
  Penulis penulis3;
  String penyebab;
  String prosesBisnis;
  String ringkasan;
  String risikoObjekPengawasan;
  String rumusanMasalah;
  String solusi;
  Statistik statistik;
  Pengetahuan statusPengetahuan;
  Pengetahuan subjenisPengetahuan;
  String syaratHasil;
  int tahunTerbit;
  String temuanMaterial;
  Thumbnail thumbnail;
  String tujuan;
  String updatedAt;
  TedBy updatedBy;

  PengetahuanResult({
    required this.createdAt,
    required this.createdBy,
    required this.dampak,
    required this.dasarHukum,
    required this.dataDigunakan,
    required this.deletedBy,
    required this.hipotesis,
    required this.id,
    required this.jenisPengetahuan,
    required this.judul,
    required this.jumlahHalaman,
    required this.keahlianDibutuhkan,
    required this.kesimpulanRekomendasi,
    required this.latarBelakang,
    required this.lessonLearned,
    required this.lingkupPengetahuan,
    required this.masalah,
    required this.metodePengawasan,
    required this.pembahasan,
    required this.penelitianTerdahulu,
    required this.pengujian,
    required this.penulis1,
    required this.penulis2,
    required this.penulis3,
    required this.penyebab,
    required this.prosesBisnis,
    required this.ringkasan,
    required this.risikoObjekPengawasan,
    required this.rumusanMasalah,
    required this.solusi,
    required this.statistik,
    required this.statusPengetahuan,
    required this.subjenisPengetahuan,
    required this.syaratHasil,
    required this.tahunTerbit,
    required this.temuanMaterial,
    required this.thumbnail,
    required this.tujuan,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory PengetahuanResult.fromJson(Map<String, dynamic> json) =>
      PengetahuanResult(
        createdAt: json["created_at"] ?? "",
        createdBy: TedBy.fromJson(json["created_by"]),
        dampak: json["dampak"] ?? "",
        dasarHukum: json["dasar_hukum"] ?? "",
        dataDigunakan: json["data_digunakan"] ?? "",
        deletedBy: TedBy.fromJson(json["deleted_by"]),
        hipotesis: json["hipotesis"] ?? "",
        id: json["id"] ?? 0,
        jenisPengetahuan: Pengetahuan.fromJson(json["jenis_pengetahuan"]),
        judul: json["judul"] ?? "",
        jumlahHalaman: json["jumlah_halaman"] ?? 0,
        keahlianDibutuhkan: json["keahlian_dibutuhkan"] ?? "",
        kesimpulanRekomendasi: json["kesimpulan_rekomendasi"] ?? "",
        latarBelakang: json["latar_belakang"] ?? "",
        lessonLearned: json["lesson_learned"] ?? "",
        lingkupPengetahuan: Pengetahuan.fromJson(json["lingkup_pengetahuan"]),
        masalah: json["masalah"] ?? "",
        metodePengawasan: json["metode_pengawasan"] ?? "",
        pembahasan: json["pembahasan"] ?? "",
        penelitianTerdahulu: json["penelitian_terdahulu"] ?? "",
        pengujian: json["pengujian"] ?? "",
        penulis1: Penulis.fromJson(json["penulis_1"]),
        penulis2: Penulis.fromJson(json["penulis_2"]),
        penulis3: Penulis.fromJson(json["penulis_3"]),
        penyebab: json["penyebab"] ?? "",
        prosesBisnis: json["proses_bisnis"] ?? "",
        ringkasan: json["ringkasan"] ?? "",
        risikoObjekPengawasan: json["risiko_objek_pengawasan"] ?? "",
        rumusanMasalah: json["rumusan_masalah"] ?? "",
        solusi: json["solusi"] ?? "",
        statistik: Statistik.fromJson(json["statistik"]),
        statusPengetahuan: Pengetahuan.fromJson(json["status_pengetahuan"]),
        subjenisPengetahuan: Pengetahuan.fromJson(json["subjenis_pengetahuan"]),
        syaratHasil: json["syarat_hasil"] ?? "",
        tahunTerbit: json["tahun_terbit"] ?? 0,
        temuanMaterial: json["temuan_material"] ?? "",
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        tujuan: json["tujuan"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        updatedBy: TedBy.fromJson(json["updated_by"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "created_by": createdBy.toJson(),
        "dampak": dampak,
        "dasar_hukum": dasarHukum,
        "data_digunakan": dataDigunakan,
        "deleted_by": deletedBy.toJson(),
        "hipotesis": hipotesis,
        "id": id,
        "jenis_pengetahuan": jenisPengetahuan.toJson(),
        "judul": judul,
        "jumlah_halaman": jumlahHalaman,
        "keahlian_dibutuhkan":
            keahlianDibutuhkan,
        "kesimpulan_rekomendasi": kesimpulanRekomendasi,
        "latar_belakang": latarBelakang,
        "lesson_learned": lessonLearned,
        "lingkup_pengetahuan": lingkupPengetahuan.toJson(),
        "masalah": masalah,
        "metode_pengawasan": metodePengawasan,
        "pembahasan": pembahasan,
        "penelitian_terdahulu": penelitianTerdahulu,
        "pengujian": pengujian,
        "penulis_1": penulis1.toJson(),
        "penulis_2": penulis2.toJson(),
        "penulis_3": penulis3.toJson(),
        "penyebab": penyebab,
        "proses_bisnis": prosesBisnis,
        "ringkasan": ringkasan,
        "risiko_objek_pengawasan":
            risikoObjekPengawasan,
        "rumusan_masalah": rumusanMasalah,
        "solusi": solusi,
        "statistik": statistik.toJson(),
        "status_pengetahuan": statusPengetahuan.toJson(),
        "subjenis_pengetahuan": subjenisPengetahuan.toJson(),
        "syarat_hasil": syaratHasil,
        "tahun_terbit": tahunTerbit,
        "temuan_material": temuanMaterial,
        "thumbnail": thumbnail.toJson(),
        "tujuan": tujuan,
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
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}

class Pengetahuan {
  int id;
  String nama;

  Pengetahuan({
    required this.id,
    required this.nama,
  });

  factory Pengetahuan.fromJson(Map<String, dynamic> json) => Pengetahuan(
        id: json["id"] ?? 0,
        nama: json["nama"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

class Penulis {
  Foto foto;
  int id;
  String jabatan;
  String nama;

  Penulis({
    required this.foto,
    required this.id,
    required this.jabatan,
    required this.nama,
  });

  factory Penulis.fromJson(Map<String, dynamic> json) => Penulis(
        foto: Foto.fromJson(json["foto"]),
        id: json["id"] ?? 0,
        jabatan: json["jabatan"] ?? "",
        nama: json["nama"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "foto": foto.toJson(),
        "id": id,
        "jabatan": jabatan,
        "nama": nama,
      };
}

class Foto {
  int id;
  String nama;
  String url;

  Foto({
    required this.id,
    required this.nama,
    required this.url,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: 0, //json["id"],
        nama: json["nama"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
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
        dislike: json["dislike"],
        komentar: json["komentar"],
        like: json["like"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "dislike": dislike,
        "komentar": komentar,
        "like": like,
        "view": view,
      };
}

class Thumbnail {
  int id;
  String nama;
  String url;

  Thumbnail({
    required this.id,
    required this.nama,
    required this.url,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        id: json["id"] ?? 0,
        nama: json["nama"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "url": url,
      };
}
