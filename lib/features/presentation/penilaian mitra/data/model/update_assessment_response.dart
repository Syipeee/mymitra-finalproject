class AssessmentResponseUpdate {
  String status;
  int code;
  final String nilai;
  final String? tanggal;

  AssessmentResponseUpdate({
    required this.status,
    required this.code,
    required this.nilai,
    required this.tanggal,
  });

  factory AssessmentResponseUpdate.fromJson(Map<String, dynamic> json) {
    return AssessmentResponseUpdate(
      status: json['status'],
      code: json['code'],
      nilai: json['data']['input']['NILAI'],
      tanggal: json['data']['input']['TANGGAL']?['value'],
    );
  }
}
