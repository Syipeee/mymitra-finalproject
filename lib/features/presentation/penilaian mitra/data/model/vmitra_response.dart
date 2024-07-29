class Vmitra {
  String nomor;
  String pic;
  String namaPerusahaan;
  String bidangUsaha;
  String alamat;
  String kota;
  String provinsi;
  String negara;
  String telp;
  String namaCp;
  String emailCp;
  String nohpCp;
  String mulaiKerjasama;
  String akhirKerjasama;
  String username;
  String password;

  Vmitra({
    required this.nomor,
    required this.pic,
    required this.namaPerusahaan,
    required this.bidangUsaha,
    required this.alamat,
    required this.kota,
    required this.provinsi,
    required this.negara,
    required this.telp,
    required this.namaCp,
    required this.emailCp,
    required this.nohpCp,
    required this.mulaiKerjasama,
    required this.akhirKerjasama,
    required this.username,
    required this.password,
  });

  factory Vmitra.fromJson(Map<String, dynamic> json) {
    return Vmitra(
      nomor: json["NOMOR"] ?? "",
      namaPerusahaan: json["NAMA_PERUSAHAAN"] ?? "",
      bidangUsaha: json["BIDANG_USAHA"] ?? "",
      alamat: json["ALAMAT"] ?? "",
      kota: json["KOTA"] ?? "",
      provinsi: json["PROVINSI"] ?? "",
      negara: json["NEGARA"] ?? "",
      telp: json["TELP"] ?? "",
      namaCp: json["NAMA_CP"] ?? "",
      emailCp: json["EMAIL_CP"] ?? "",
      nohpCp: json["NOHP_CP"] ?? "",
      pic: json["PIC"] ?? "",
      mulaiKerjasama: json["MULAI_KERJASAMA"] ?? "",
      akhirKerjasama: json["AKHIR_KERJASAMA"] ?? "",
      username: json["USERNAME"] ?? "",
      password: json["PASSWORD"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "NOMOR": nomor,
        "NAMA_PERUSAHAAN": namaPerusahaan,
        "BIDANG_USAHA": bidangUsaha,
        "ALAMAT": alamat,
        "KOTA": kota,
        "PROVINSI": provinsi,
        "NEGARA": negara,
        "TELP": telp,
        "NAMA_CP": namaCp,
        "EMAIL_CP": emailCp,
        "NOHP_CP": nohpCp,
        "PIC": pic,
        "MULAI_KERJASAMA": mulaiKerjasama,
        "AKHIR_KERJASAMA": akhirKerjasama,
        "USERNAME": username,
        "PASSWORD": password,
      };
}
