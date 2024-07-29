class QuisPertanyaan {
  final String nomor;
  final String pertanyaan;
  final String isIsian;
  final String quisJenis;

  QuisPertanyaan({
    required this.nomor,
    required this.pertanyaan,
    required this.isIsian,
    required this.quisJenis,
  });

  factory QuisPertanyaan.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');
    return QuisPertanyaan(
      nomor: json['NOMOR'] ?? "",
      pertanyaan: json['PERTANYAAN'] ?? "",
      isIsian: json['IS_ISIAN'] ?? "",
      quisJenis: json['QUIS_JENIS'] ?? "",
    );
  }
}
