import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<SliderModel>.from(jsonData.map((x) => SliderModel.fromJson(x)));
}

String sliderModelToJson(List<SliderModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class SliderModel {
  dynamic akademi;
  String createdAt;
  TedBy createdBy;
  dynamic dampak;
  dynamic dasarHukum;
  dynamic dataDigunakan;
  dynamic deletedAt;
  TedBy deletedBy;
  dynamic dokumen;
  dynamic hipotesis;
  int id;
  dynamic isDisliked;
  dynamic isLiked;
  Pengetahuan jenisPengetahuan;
  String judul;
  dynamic jumlahHalaman;
  dynamic keahlianDibutuhkan;
  dynamic kesimpulanRekomendasi;
  dynamic kompetensi;
  dynamic latarBelakang;
  dynamic lessonLearned;
  Levenshtein levenshtein;
  Pengetahuan lingkupPengetahuan;
  dynamic masalah;
  dynamic metodePengawasan;
  dynamic narasumber;
  dynamic pedoman;
  dynamic pembahasan;
  dynamic penelitianTerdahulu;
  dynamic penerbit;
  dynamic pengujian;
  Penulis penulis1;
  Penulis penulis2;
  Penulis penulis3;
  dynamic penulisExternal;
  dynamic penyebab;
  dynamic prosesBisnis;
  dynamic referensi;
  String ringkasan;
  dynamic risikoObjekPengawasan;
  dynamic rumusanMasalah;
  dynamic solusi;
  Statistik statistik;
  Pengetahuan statusPengetahuan;
  Pengetahuan subjenisPengetahuan;
  dynamic syaratHasil;
  dynamic tag;
  dynamic tahunTerbit;
  dynamic temuanMaterial;
  dynamic tenagaAhli;
  Thumbnail thumbnail;
  dynamic tujuan;
  String updatedAt;
  TedBy updatedBy;

  SliderModel({
    required this.akademi,
    required this.createdAt,
    required this.createdBy,
    required this.dampak,
    required this.dasarHukum,
    required this.dataDigunakan,
    required this.deletedAt,
    required this.deletedBy,
    required this.dokumen,
    required this.hipotesis,
    required this.id,
    required this.isDisliked,
    required this.isLiked,
    required this.jenisPengetahuan,
    required this.judul,
    required this.jumlahHalaman,
    required this.keahlianDibutuhkan,
    required this.kesimpulanRekomendasi,
    required this.kompetensi,
    required this.latarBelakang,
    required this.lessonLearned,
    required this.levenshtein,
    required this.lingkupPengetahuan,
    required this.masalah,
    required this.metodePengawasan,
    required this.narasumber,
    required this.pedoman,
    required this.pembahasan,
    required this.penelitianTerdahulu,
    required this.penerbit,
    required this.pengujian,
    required this.penulis1,
    required this.penulis2,
    required this.penulis3,
    required this.penulisExternal,
    required this.penyebab,
    required this.prosesBisnis,
    required this.referensi,
    required this.ringkasan,
    required this.risikoObjekPengawasan,
    required this.rumusanMasalah,
    required this.solusi,
    required this.statistik,
    required this.statusPengetahuan,
    required this.subjenisPengetahuan,
    required this.syaratHasil,
    required this.tag,
    required this.tahunTerbit,
    required this.temuanMaterial,
    required this.tenagaAhli,
    required this.thumbnail,
    required this.tujuan,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        akademi: json["akademi"],
        createdAt: json["created_at"],
        createdBy: TedBy.fromJson(json["created_by"]),
        dampak: json["dampak"],
        dasarHukum: json["dasar_hukum"],
        dataDigunakan: json["data_digunakan"],
        deletedAt: json["deleted_at"],
        deletedBy: TedBy.fromJson(json["deleted_by"]),
        dokumen: json["dokumen"],
        hipotesis: json["hipotesis"],
        id: json["id"],
        isDisliked: json["is_disliked"],
        isLiked: json["is_liked"],
        jenisPengetahuan: Pengetahuan.fromJson(json["jenis_pengetahuan"]),
        judul: json["judul"],
        jumlahHalaman: json["jumlah_halaman"],
        keahlianDibutuhkan: json["keahlian_dibutuhkan"],
        kesimpulanRekomendasi: json["kesimpulan_rekomendasi"],
        kompetensi: json["kompetensi"],
        latarBelakang: json["latar_belakang"],
        lessonLearned: json["lesson_learned"],
        levenshtein: Levenshtein.fromJson(json["levenshtein"]),
        lingkupPengetahuan: Pengetahuan.fromJson(json["lingkup_pengetahuan"]),
        masalah: json["masalah"],
        metodePengawasan: json["metode_pengawasan"],
        narasumber: json["narasumber"],
        pedoman: json["pedoman"],
        pembahasan: json["pembahasan"],
        penelitianTerdahulu: json["penelitian_terdahulu"],
        penerbit: json["penerbit"],
        pengujian: json["pengujian"],
        penulis1: Penulis.fromJson(json["penulis_1"]),
        penulis2: Penulis.fromJson(json["penulis_2"]),
        penulis3: Penulis.fromJson(json["penulis_3"]),
        penulisExternal: json["penulis_external"],
        penyebab: json["penyebab"],
        prosesBisnis: json["proses_bisnis"],
        referensi: json["referensi"],
        ringkasan: json["ringkasan"],
        risikoObjekPengawasan: json["risiko_objek_pengawasan"],
        rumusanMasalah: json["rumusan_masalah"],
        solusi: json["solusi"],
        statistik: Statistik.fromJson(json["statistik"]),
        statusPengetahuan: Pengetahuan.fromJson(json["status_pengetahuan"]),
        subjenisPengetahuan: Pengetahuan.fromJson(json["subjenis_pengetahuan"]),
        syaratHasil: json["syarat_hasil"],
        tag: json["tag"],
        tahunTerbit: json["tahun_terbit"],
        temuanMaterial: json["temuan_material"],
        tenagaAhli: json["tenaga_ahli"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        tujuan: json["tujuan"],
        updatedAt: json["updated_at"],
        updatedBy: TedBy.fromJson(json["updated_by"]),
      );

  Map<String, dynamic> toJson() => {
        "akademi": akademi,
        "created_at": createdAt,
        "created_by": createdBy.toJson(),
        "dampak": dampak,
        "dasar_hukum": dasarHukum,
        "data_digunakan": dataDigunakan,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy.toJson(),
        "dokumen": dokumen,
        "hipotesis": hipotesis,
        "id": id,
        "is_disliked": isDisliked,
        "is_liked": isLiked,
        "jenis_pengetahuan": jenisPengetahuan.toJson(),
        "judul": judul,
        "jumlah_halaman": jumlahHalaman,
        "keahlian_dibutuhkan": keahlianDibutuhkan,
        "kesimpulan_rekomendasi": kesimpulanRekomendasi,
        "kompetensi": kompetensi,
        "latar_belakang": latarBelakang,
        "lesson_learned": lessonLearned,
        "levenshtein": levenshtein.toJson(),
        "lingkup_pengetahuan": lingkupPengetahuan.toJson(),
        "masalah": masalah,
        "metode_pengawasan": metodePengawasan,
        "narasumber": narasumber,
        "pedoman": pedoman,
        "pembahasan": pembahasan,
        "penelitian_terdahulu": penelitianTerdahulu,
        "penerbit": penerbit,
        "pengujian": pengujian,
        "penulis_1": penulis1.toJson(),
        "penulis_2": penulis2.toJson(),
        "penulis_3": penulis3.toJson(),
        "penulis_external": penulisExternal,
        "penyebab": penyebab,
        "proses_bisnis": prosesBisnis,
        "referensi": referensi,
        "ringkasan": ringkasan,
        "risiko_objek_pengawasan": risikoObjekPengawasan,
        "rumusan_masalah": rumusanMasalah,
        "solusi": solusi,
        "statistik": statistik.toJson(),
        "status_pengetahuan": statusPengetahuan.toJson(),
        "subjenis_pengetahuan": subjenisPengetahuan.toJson(),
        "syarat_hasil": syaratHasil,
        "tag": tag,
        "tahun_terbit": tahunTerbit,
        "temuan_material": temuanMaterial,
        "tenaga_ahli": tenagaAhli,
        "thumbnail": thumbnail.toJson(),
        "tujuan": tujuan,
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

class Pengetahuan {
  int id;
  String nama;

  Pengetahuan({
    required this.id,
    required this.nama,
  });

  factory Pengetahuan.fromJson(Map<String, dynamic> json) => Pengetahuan(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

class Levenshtein {
  dynamic distance;
  dynamic keyword;
  dynamic percentage;

  Levenshtein({
    this.distance,
    this.keyword,
    this.percentage,
  });

  factory Levenshtein.fromJson(Map<String, dynamic> json) => Levenshtein(
        distance: json["distance"],
        keyword: json["keyword"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "keyword": keyword,
        "percentage": percentage,
      };
}

class Penulis {
  Thumbnail foto;
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
        foto: Thumbnail.fromJson(json["foto"]),
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
