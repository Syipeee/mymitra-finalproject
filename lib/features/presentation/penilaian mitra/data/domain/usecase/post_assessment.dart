import 'dart:ui';

import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/insert_nilai_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/insert_assessment_response.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';

class PostInsertAssessment {
  final InsertAssessmentRepository repository;

  PostInsertAssessment(this.repository);

  Future<List<AssessmentData>> postInsertNilaiAssessmentData({
    VoidCallback? onSuccess,
    VoidCallback? onError,
    required KategoriAssessment kategoriAssessment,
    required VPendaftar pendaftar,
    required VPendaftar vmitra,
    required String nilai,
  }) async {
    try {
      final List<AssessmentData> result =
          await repository.postInsertNilaiAssessment(
        kategoriAssessment: kategoriAssessment.nomor,
        pendaftar: pendaftar.nomor,
        vmitra: vmitra.vmitra,
        nilai: nilai,
      );

      // print('aku: ${jsonEncode(kategoriAssessment)}');
      // print('aju: ${jsonEncode(pendaftar)}');
      // print('aku: $nilai');

      if (result.isNotEmpty && result.first.status == 'sukses') {
        onSuccess?.call();
      } else {
        onError?.call();
      }
      return result;
    } catch (e) {
      print('Error in postInsertNilaiAssessmentData: $e');
      rethrow;
    }
  }
}
