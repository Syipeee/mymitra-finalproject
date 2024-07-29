class VReadAssessmentData {
  String nomor;
  String namaKategoriAssessment;
  String kategoriAssessment;
  String mahasiswa;
  String nrp;
  String nama;
  String nilai;
  String pegawai;
  String namaPegawai;
  String vmitra;
  String namaVmitra;
  String tanggal;

  VReadAssessmentData({
    required this.nomor,
    required this.namaKategoriAssessment,
    required this.kategoriAssessment,
    required this.mahasiswa,
    required this.nrp,
    required this.nama,
    required this.nilai,
    required this.pegawai,
    required this.namaPegawai,
    required this.namaVmitra,
    required this.vmitra,
    required this.tanggal,
  });

  factory VReadAssessmentData.fromJson(Map<String, dynamic> json) {
    return VReadAssessmentData(
      nomor: json['NOMOR'],
      namaKategoriAssessment: json['NAMA_KATEGORI_ASSESMENT'] ?? '',
      kategoriAssessment: json['KATEGORI_ASSESMENT'] ?? '',
      mahasiswa: json['MAHASISWA'] ?? '',
      nrp: json['NRP'] ?? '',
      nama: json['NAMA'] ?? '',
      pegawai: json['PEGAWAI'] ?? '',
      namaPegawai: json['NAMA_PEGAWAI'] ?? '',
      namaVmitra: json['NAMA_VMITRA'] ?? '',
      vmitra: json['VMITRA'] ?? '',
      nilai: json['NILAI'] ?? '',
      tanggal: json['TANGGAL'],
    );
  }

  where(Function(dynamic assessment) param0) {}
}
