import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/post_assessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';

class InsertAssessmentProviders extends ChangeNotifier {
  final PostInsertAssessment postInsertNilaiAssessment;
  // final String nomorPenguji;

  InsertAssessmentProviders({
    required this.postInsertNilaiAssessment,
    // required this.nomorPenguji,
  });

  final nilaiController = TextEditingController();
  Future<void> postInsertNilaiAssessmentData({
    VoidCallback? onSuccess,
    VoidCallback? onError,
    required KategoriAssessment kategoriAssessment,
    required VPendaftar pendaftar,
    required VPendaftar vmitra,
    required String nilai,
  }) async {
    try {
      // Tambahkan pengecekan untuk nilai kategoriAssessment, pendaftar, dan nilai
      // print kategori menggunkkan json encode
      // print('kategori: ${jsonEncode(kategoriAssessment)}');
      // print('pendaftar: ${jsonEncode(pendaftar)}');
      // print('nilai: $nilai');

      final result =
          await postInsertNilaiAssessment.postInsertNilaiAssessmentData(
        kategoriAssessment: kategoriAssessment,
        pendaftar: pendaftar,
        nilai: nilai,
        vmitra: vmitra,
      );
      if (result.isNotEmpty) {
        if (result.first.status == 'sukses') {
          print('Data berhasil diinput');
          onSuccess?.call();
        } else {
          print('Data gagal diinput');
          onError?.call();
        }
      } else {
        print('Data gagal diinput');
        onError?.call();
      }
    } catch (e) {
      print('Error in postInsertNilaiAssessmentData: $e');
      onError?.call();
    }
  }

  void clear() {
    nilaiController.clear();
    notifyListeners();
  }
}
