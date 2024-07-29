class LogbookPendaftarMonitoring {
  final String nomor;
  final String pendaftar;
  final String tanggal;
  final String namaKegiatan;
  final String latitude;
  final String longitude;

  LogbookPendaftarMonitoring({
    required this.nomor,
    required this.pendaftar,
    required this.tanggal,
    required this.namaKegiatan,
    required this.latitude,
    required this.longitude,
  });

  factory LogbookPendaftarMonitoring.fromJson(Map<String, dynamic> json) {
    return LogbookPendaftarMonitoring(
      nomor: json['NOMOR'] ?? "",
      pendaftar: json['PENDAFTAR'] ?? "",
      tanggal: json['TANGGAL'] ?? "",
      namaKegiatan: json['NAMA_KEGIATAN'] ?? "",
      latitude: json['LATITUDE'] ?? "",
      longitude: json['LONGITUDE'] ?? "",
    );
  }
}
