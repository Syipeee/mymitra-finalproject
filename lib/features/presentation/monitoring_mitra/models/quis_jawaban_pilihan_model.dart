class QuisJawabanPilihan {
  final String nomor;
  final String quisPertanyaan;
  final String urutan;
  final String jawaban;
  final String bobot;

  QuisJawabanPilihan({
    required this.nomor,
    required this.quisPertanyaan,
    required this.urutan,
    required this.jawaban,
    required this.bobot,
  });

  factory QuisJawabanPilihan.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');
    return QuisJawabanPilihan(
      nomor: json['NOMOR'] ?? "",
      quisPertanyaan: json['QUIS_PERTANYAAN'] ?? "",
      urutan: json['URUTAN'] ?? "",
      jawaban: json['JAWABAN'] ?? "",
      bobot: json['BOBOT'] ?? "",
    );
  }
}
