import 'dart:convert';

TokenModel tokenModelFromJson(String str) {
  final jsonData = json.decode(str);
  return TokenModel.fromJson(jsonData);
}

String tokenModelToJson(TokenModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class TokenModel {
  String accessToken;
  String createdAt;
  dynamic deletedAt;
  String expiredAt;
  dynamic ipAddress;
  String updatedAt;
  User user;

  TokenModel({
    required this.accessToken,
    required this.createdAt,
    required this.deletedAt,
    required this.expiredAt,
    required this.ipAddress,
    required this.updatedAt,
    required this.user,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"] ?? "",
        createdAt: json["created_at"] ?? "",
        deletedAt: json["deleted_at"],
        expiredAt: json["expired_at"] ?? "",
        ipAddress: json["ip_address"],
        updatedAt: json["updated_at"] ?? "",
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "expired_at": expiredAt,
        "ip_address": ipAddress,
        "updated_at": updatedAt,
        "user": user.toJson(),
      };
}

class User {
  dynamic email;
  Foto foto;
  int id;
  String jabatan;
  String jenis;
  dynamic level;
  String namaLengkap;
  String namaPanggilan;
  String nip;
  Orang orang;
  String password;
  dynamic statusLevel;
  dynamic totalPoint;
  dynamic unitKerja;
  String username;

  User({
    required this.email,
    required this.foto,
    required this.id,
    required this.jabatan,
    required this.jenis,
    required this.level,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.nip,
    required this.orang,
    required this.password,
    required this.statusLevel,
    required this.totalPoint,
    required this.unitKerja,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] ?? "",
        foto: Foto.fromJson(json["foto"]),
        id: json["id"] ?? 0,
        jabatan: json["jabatan"] ?? "",
        jenis: json["jenis"] ?? "",
        level: json["level"],
        namaLengkap: json["nama_lengkap"] ?? "",
        namaPanggilan: json["nama_panggilan"] ?? "",
        nip: json["nip"] ?? "",
        orang: Orang.fromJson(json["orang"]),
        password: json["password"] ?? "",
        statusLevel: json["status_level"],
        totalPoint: json["total_point"],
        unitKerja: json["unit_kerja"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "foto": foto.toJson(),
        "id": id,
        "jabatan": jabatan,
        "jenis": jenis,
        "level": level,
        "nama_lengkap": namaLengkap,
        "nama_panggilan": namaPanggilan,
        "nip": nip,
        "orang": orang.toJson(),
        "password": password,
        "status_level": statusLevel,
        "total_point": totalPoint,
        "unit_kerja": unitKerja,
        "username": username,
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

class Orang {
  dynamic id;

  Orang({
    this.id,
  });

  factory Orang.fromJson(Map<String, dynamic> json) => Orang(
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
